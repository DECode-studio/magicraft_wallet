// content.js
// Inject the script into the page and remove tag after load
const script = document.createElement('script');
script.src = chrome.runtime.getURL('inject.js');
script.onload = () => {
    script.remove();
};
(document.head || document.documentElement).appendChild(script);

// Listen messages from injected page script (window.postMessage)
window.addEventListener("message", (event) => {
    if (event.source !== window) return;
    if (event.data?.source !== "FLUTTER_WALLET_REQUEST") return;

    const { id, method, params } = event.data;

    // forward to extension background
    chrome.runtime.sendMessage({ id, method, params }, (response) => {
        // send back to page (inject.js)
        window.postMessage({
            source: "FLUTTER_WALLET_RESPONSE",
            id,
            result: response?.result,
            error: response?.error
        }, "*");
    });
});

// Listen for wallet state updates from background and forward to page (so provider._updateFromWallet can consume)
chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
    if (msg && msg.type === "wallet_state_update") {
        window.postMessage({
            source: "FLUTTER_WALLET_INTERNAL",
            payload: msg.payload
        }, "*");
        // optionally respond to sender
        sendResponse && sendResponse({ result: "forwarded" });
    }
});