console.log("🚀 Content script loaded");

const script = document.createElement("script");
script.src = chrome.runtime.getURL("inject.js");
script.onload = () => script.remove();
(document.head || document.documentElement).appendChild(script);

let flutterHandlerReady = false;
let messageQueue = [];

function sendToFlutter(msg) {
    const fn = window.onMessageFromExtension;
    if (typeof fn === "function") {
        console.log("➡️ Forwarding to Flutter via onMessageFromExtension", msg);
        try {
            fn(JSON.stringify(msg));
        } catch (err) {
            console.error("❌ Error calling Flutter handler:", err);
        }
    } else {
        console.warn("⚠️ Flutter handler belum siap, queueing", msg);
        messageQueue.push(msg);
    }
}

const interval = setInterval(() => {
    if (typeof window.onMessageFromExtension === "function") {
        if (!flutterHandlerReady) {
            console.log("✅ Flutter handler terdeteksi, flushing queue...");
            flutterHandlerReady = true;

            while (messageQueue.length > 0) {
                const q = messageQueue.shift();
                sendToFlutter(q);
            }
        }
    }
}, 500);

window.addEventListener("message", (event) => {
    if (event.source !== window) return;

    if (event.data?.source === "FLUTTER_WALLET_REQUEST") {
        const { id, method, params } = event.data;
        console.log("📩 DApp request:", event.data);

        chrome.runtime.sendMessage({ id, method, params }, (response) => {
            window.postMessage(
                {
                    source: "FLUTTER_WALLET_RESPONSE",
                    id,
                    result: response?.result,
                    error: response?.error,
                },
                "*"
            );
        });
    }

    if (event.data?.source === "FLUTTER_WALLET_POPUP_READY") {
        console.log("✅ Popup ready signal received");
        chrome.runtime.sendMessage({ type: "popup_ready" });
    }
});

chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
    if (!msg) return;

    if (msg.type === "wallet_state_update") {
        window.postMessage(
            {
                source: "FLUTTER_WALLET_INTERNAL",
                payload: msg.payload,
            },
            "*"
        );
        sendResponse && sendResponse({ result: "forwarded" });
        return;
    }

    if (msg.type === "wallet_request") {
        console.log("📩 Got wallet_request from background:", msg);

        sendToFlutter({
            id: msg.id,
            method: msg.method,
            params: msg.params,
        });

        sendResponse && sendResponse({ result: "forwarded to flutter" });
        return;
    }
});
