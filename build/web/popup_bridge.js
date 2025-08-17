console.log("🔗 popup_bridge injected");

let popupReady = false;

window.addEventListener("message", (event) => {
    if (!event.data) return;


    if (event.data.source === "FLUTTER_WALLET_POPUP_READY") {
        console.log("✅ Popup ready received from Flutter");
        popupReady = true;
        chrome.runtime.sendMessage({ type: "popup_ready" });
    }


    if (event.data.source === "FLUTTER_WALLET_RESPONSE") {
        chrome.runtime.sendMessage({
            type: "wallet_popup_response",
            id: event.data.id,
            result: event.data.result,
            error: event.data.error,
        });
    }
});

chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
    if (msg.type === "wallet_request") {
        if (!popupReady) {
            console.log("⏳ Popup not ready, queueing message", msg);
            return;
        }
        console.log("➡️ Forwarding wallet_request to Flutter", msg);

        window.postMessage(
            {
                source: "WALLET_REQUEST",
                id: msg.id,
                method: msg.method,
                params: msg.params,
            },
            "*"
        );
    }
});
