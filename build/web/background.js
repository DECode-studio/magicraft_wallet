const POPUP_METHODS = new Set([
    "eth_chainId",
    "wallet_getPermissions",
    "wallet_revokePermissions",
    "eth_requestAccounts",
    "wallet_requestPermissions",
]);

let popupWindowId = null;
let popupReady = false;
const pending = {};
const messageQueue = [];

const walletState = {
    accounts: [],
    chainId: null,
};

function openOrFocusPopup() {
    const url = chrome.runtime.getURL("index.html");

    if (popupWindowId !== null) {
        chrome.windows.update(popupWindowId, { focused: true }, (win) => {
            if (chrome.runtime.lastError || !win) {
                chrome.windows.create(
                    { url, type: "popup", width: 400, height: 600 },
                    (w) => {
                        if (chrome.runtime.lastError) {
                            console.warn("Failed to create popup:", chrome.runtime.lastError.message);
                            return;
                        }
                        popupWindowId = w.id;
                    }
                );
            }
        });
    } else {
        chrome.windows.create({ url, type: "popup", width: 400, height: 600 }, (w) => {
            if (chrome.runtime.lastError) {
                console.warn("Failed to create popup:", chrome.runtime.lastError.message);
                return;
            }
            popupWindowId = w.id;
        });
    }
}

function broadcastState() {
    chrome.tabs.query({}, (tabs) => {
        for (const tab of tabs) {
            if (!tab.id) continue;
            chrome.tabs.sendMessage(
                tab.id,
                {
                    type: "wallet_state_update",
                    payload: { accounts: walletState.accounts, chainId: walletState.chainId },
                },
                () => { }
            );
        }
    });
}

function flushQueue() {
    console.log("✅ Flushing queued messages:", messageQueue.length);
    chrome.tabs.query({}, (tabs) => {
        while (messageQueue.length > 0) {
            const msg = messageQueue.shift();
            for (const tab of tabs) {
                if (!tab.id) continue;
                chrome.tabs.sendMessage(tab.id, msg, () => {
                    if (chrome.runtime.lastError) {
                        console.warn("Failed to deliver queued message:", chrome.runtime.lastError.message);
                    }
                });
            }
        }
    });
}

chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
    if (!msg) return;


    if (msg.type === "popup_ready") {
        console.log("🎉 Popup ready!");
        popupReady = true;
        flushQueue();
        sendResponse && sendResponse({ result: "ok" });
        return true;
    }


    if (msg.type === "wallet_popup_response" && typeof msg.id !== "undefined") {
        const entry = pending[msg.id];
        if (msg.result && typeof msg.result === "object") {
            if (Array.isArray(msg.result.accounts)) walletState.accounts = msg.result.accounts;
            if (typeof msg.result.chainId !== "undefined") walletState.chainId = msg.result.chainId;
            broadcastState();
        }
        if (entry) {
            clearTimeout(entry.timer);
            entry.sendResponse({ result: msg.result, error: msg.error });
            delete pending[msg.id];
        }
        return true;
    }


    if (msg.type === "get_pending_requests") {
        const list = Object.keys(pending).map((id) => {
            const p = pending[id];
            return { id: Number(id), method: p.method, params: p.params };
        });
        sendResponse({ requests: list });
        return true;
    }


    if (msg.type === "wallet_set_state") {
        if (msg.payload) {
            if (Array.isArray(msg.payload.accounts)) walletState.accounts = msg.payload.accounts;
            if (typeof msg.payload.chainId !== "undefined") walletState.chainId = msg.payload.chainId;
            broadcastState();
            sendResponse({ result: "ok" });
        } else {
            sendResponse({ error: "missing payload" });
        }
        return true;
    }


    const { id, method, params } = msg;
    if (typeof id === "undefined" || !method) {
        sendResponse({ error: "invalid request" });
        return true;
    }


    if (method === "eth_accounts") {
        sendResponse({ result: walletState.accounts || [] });
        return true;
    }


    if (POPUP_METHODS.has(method)) {
        if (pending[id]) {
            sendResponse({ error: "duplicate request id" });
            return true;
        }

        pending[id] = {
            sendResponse,
            method,
            params,
            timer: setTimeout(() => {
                if (pending[id]) {
                    pending[id].sendResponse({ error: "timeout waiting for user interaction" });
                    delete pending[id];
                }
            }, 60_000),
        };

        openOrFocusPopup();

        const requestMsg = { type: "wallet_request", id, method, params };
        if (popupReady) {
            console.log("✅ Popup ready", requestMsg);


            chrome.runtime.sendMessage(requestMsg, () => {
                if (chrome.runtime.lastError) {
                    console.warn("Popup message error:", chrome.runtime.lastError.message);
                }
            });

        } else {
            console.log("⏳ Popup not ready, queueing message", requestMsg);
            messageQueue.push(requestMsg);
        }

        return true;
    }


    chrome.runtime.sendMessage({ type: "wallet_request", id, method, params }, (response) => {
        if (chrome.runtime.lastError) {
            sendResponse({ error: chrome.runtime.lastError.message });
        } else {
            sendResponse(response);
        }
    });

    return true;
});
