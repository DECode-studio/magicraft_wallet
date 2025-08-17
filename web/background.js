// background.js
const POPUP_METHODS = new Set([
    "eth_chainId",
    "wallet_getPermissions",
    "wallet_revokePermissions",
    "eth_requestAccounts",
    "wallet_requestPermissions"
]);

let popupWindowId = null;
const pending = {}; // { [id]: { sendResponse, timer } }

// simple in-memory wallet state (accounts, chainId)
const walletState = {
    accounts: [], // array of hex addresses
    chainId: null
};

function openOrFocusPopup() {
    const url = chrome.runtime.getURL('index.html');
    if (popupWindowId !== null) {
        chrome.windows.update(popupWindowId, { focused: true }, (win) => {
            if (chrome.runtime.lastError || !win) {
                chrome.windows.create({ url, type: "popup", width: 400, height: 600 }, (w) => {
                    popupWindowId = w.id;
                });
            }
        });
    } else {
        chrome.windows.create({ url, type: "popup", width: 400, height: 600 }, (w) => {
            popupWindowId = w.id;
        });
    }
}

function broadcastState() {
    // send wallet state to all tabs so content.js can forward to the page
    chrome.tabs.query({}, (tabs) => {
        for (const tab of tabs) {
            if (!tab.id) continue;
            chrome.tabs.sendMessage(tab.id, { type: "wallet_state_update", payload: { accounts: walletState.accounts, chainId: walletState.chainId } }, () => {
                // ignore errors (tab may not have content script)
            });
        }
    });
}

// Listen messages from content script (forwarded from page) and from popup UI
chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
    console.log("Background got:", msg, "from", sender && sender.id);

    // If popup UI finished and posts result back: { type: "wallet_popup_response", id, result?, error? }
    if (msg && msg.type === "wallet_popup_response" && typeof msg.id !== "undefined") {
        const entry = pending[msg.id];
        // Optionally update walletState if popup provided accounts/chainId
        if (msg.result && typeof msg.result === "object") {
            if (Array.isArray(msg.result.accounts)) {
                walletState.accounts = msg.result.accounts;
            }
            if (typeof msg.result.chainId !== "undefined") {
                walletState.chainId = msg.result.chainId;
            }
            // broadcast new state to tabs/pages
            broadcastState();
        }

        if (entry) {
            clearTimeout(entry.timer);
            entry.sendResponse({ result: msg.result, error: msg.error });
            delete pending[msg.id];
        }
        return; // no async response expected
    }

    // If UI or other extension code asks to set state directly
    if (msg && msg.type === "wallet_set_state") {
        if (msg.payload) {
            if (Array.isArray(msg.payload.accounts)) walletState.accounts = msg.payload.accounts;
            if (typeof msg.payload.chainId !== "undefined") walletState.chainId = msg.payload.chainId;
            broadcastState();
            sendResponse({ result: "ok" });
        } else {
            sendResponse({ error: "missing payload" });
        }
        return;
    }

    // We expect content to forward `id`, `method`, `params`
    const { id, method, params } = msg || {};

    if (typeof id === "undefined" || !method) {
        // invalid message; respond with error
        sendResponse({ error: "invalid request" });
        return;
    }

    // Handle eth_accounts immediately (no popup) - return currently known accounts
    if (method === "eth_accounts") {
        sendResponse({ result: walletState.accounts || [] });
        return;
    }

    // Methods that should open wallet popup (approval flows)
    if (POPUP_METHODS.has(method)) {
        // store pending response until popup replies
        if (pending[id]) {
            sendResponse({ error: "duplicate request id" });
            return;
        }

        pending[id] = {
            sendResponse,
            timer: setTimeout(() => {
                if (pending[id]) {
                    pending[id].sendResponse({ error: "timeout waiting for user interaction" });
                    delete pending[id];
                }
            }, 60_000) // 60s timeout
        };

        openOrFocusPopup();

        // return true to indicate we'll call sendResponse asynchronously
        return true;
    }

    // For other methods we forward to UI/background wallet handler (if any)
    chrome.runtime.sendMessage({ type: "wallet_request", id, method, params }, (response) => {
        if (chrome.runtime.lastError) {
            sendResponse({ error: chrome.runtime.lastError.message });
        } else {
            sendResponse(response);
        }
    });

    return true; // indicate async response
});