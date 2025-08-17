// inject.js
// Provider injected into the web page: window.ethereum
(function () {
    const CHANNEL_REQUEST = "FLUTTER_WALLET_REQUEST";
    const CHANNEL_RESPONSE = "FLUTTER_WALLET_RESPONSE";
    const CHANNEL_INTERNAL = "FLUTTER_WALLET_INTERNAL";

    class FlutterWalletProvider {
        constructor() {
            this.isFlutterWallet = true;
            this.isMetaMask = true; // some sites check this
            this._listeners = {};
            this._id = 0;
            this._pending = {}; // id -> {resolve, reject}
            this.selectedAddress = null;
            this.chainId = null;

            window.addEventListener("message", (event) => {
                if (event.source !== window) return;
                if (event.data?.source !== CHANNEL_RESPONSE) return;

                const { id, result, error } = event.data;
                const cb = this._pending[id];
                if (cb) {
                    if (error) cb.reject(error);
                    else cb.resolve(result);
                    delete this._pending[id];
                }
            });

            // Listen for internal updates forwarded by content script
            window.addEventListener("message", (event) => {
                if (event.source !== window) return;
                if (event.data?.source !== CHANNEL_INTERNAL) return;
                const payload = event.data.payload || {};
                this._updateFromWallet(payload);
            });
        }

        request({ method, params } = {}) {
            const id = ++this._id;
            return new Promise((resolve, reject) => {
                this._pending[id] = { resolve, reject };
                window.postMessage({
                    source: CHANNEL_REQUEST,
                    id,
                    method,
                    params
                }, "*");
            });
        }

        // explicit helper for eth_accounts so callers can do ethereum.eth_accounts()
        eth_accounts() {
            return this.request({ method: "eth_accounts" });
        }

        // legacy enable support (some dapps call ethereum.enable())
        enable() {
            return this.request({ method: "eth_requestAccounts" });
        }

        // Events: accountsChanged, chainChanged, connect, disconnect
        on(event, handler) {
            if (!this._listeners[event]) this._listeners[event] = [];
            this._listeners[event].push(handler);
        }

        removeListener(event, handler) {
            if (!this._listeners[event]) return;
            this._listeners[event] = this._listeners[event].filter(h => h !== handler);
        }

        _emit(event, data) {
            if (this._listeners[event]) {
                this._listeners[event].forEach(fn => {
                    try { fn(data); } catch (e) { console.error("handler error", e); }
                });
            }
        }

        // helper to update local state and emit events (called by extension via content.js -> page)
        _updateFromWallet({ accounts, chainId }) {
            if (Array.isArray(accounts)) {
                const prev = this.selectedAddress;
                this.selectedAddress = accounts[0] || null;
                if (prev !== this.selectedAddress) {
                    this._emit("accountsChanged", accounts);
                }
            }
            if (typeof chainId !== "undefined" && chainId !== this.chainId) {
                this.chainId = chainId;
                this._emit("chainChanged", chainId);
            }
        }

        // optional: small compatibility shim for send/sendAsync (legacy)
        send(payloadOrMethod, callbackOrParams) {
            // Very small shim: if first arg is string -> treat as method
            if (typeof payloadOrMethod === "string") {
                return this.request({ method: payloadOrMethod, params: callbackOrParams });
            }
            // else assume payload object
            const payload = payloadOrMethod;
            const id = payload.id || ++this._id;
            return new Promise((resolve, reject) => {
                this._pending[id] = { resolve, reject };
                window.postMessage({
                    source: CHANNEL_REQUEST,
                    id,
                    method: payload.method,
                    params: payload.params
                }, "*");
                // if callback provided, call with (err, res) by wiring into promise resolution if needed
                if (typeof callbackOrParams === "function") {
                    this._pending[id].cb = callbackOrParams;
                }
            });
        }
    }

    const provider = new FlutterWalletProvider();

    // define window.ethereum non-enumerable and non-writable to mimic MetaMask better
    try {
        Object.defineProperty(window, 'ethereum', {
            configurable: false,
            enumerable: false,
            writable: false,
            value: provider
        });
    } catch (e) {
        // fallback
        window.ethereum = provider;
    }
})();