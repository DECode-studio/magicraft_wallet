'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "b6e656477849320a5374ff8435a9fb0c",
"popup_bridge.js": "2b57bb109f1112ddb2cc0f80641bf206",
"version.json": "49cbffe05b4cc0ac3d7a6064e6ef1449",
"index.html": "2df9566f281efa09fe13dfe740c4c9a2",
"/": "2df9566f281efa09fe13dfe740c4c9a2",
"background.js": "eb29239c9f9e0a9bb6952570dc9b0675",
"main.dart.js": "fa219d01b4483efe83efc8d4c88ac85a",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"favicon.png": "b0d6a60a57a0fbe5741e01b8bfc0a6cf",
"icons/Icon-192.png": "ce1aa0b6f6546afb2feebf3f3603845c",
"icons/Icon-maskable-192.png": "ce1aa0b6f6546afb2feebf3f3603845c",
"icons/Icon-maskable-512.png": "51314ab549da356c76cd442b1a76b337",
"icons/Icon-128.png": "ce1aa0b6f6546afb2feebf3f3603845c",
"icons/Icon-512.png": "51314ab549da356c76cd442b1a76b337",
"manifest.json": "195a81dc2744340a6a001d166bab4ffd",
"inject.js": "e5339613ad3bb401d80210252eb4fd27",
"content.js": "47cdb2408bf4d45131907b01dad3d3ac",
"assets/AssetManifest.json": "d0b6c4a807d650aeab0a4ccf47846c17",
"assets/NOTICES": "bd70b47ce62f9cd1ead7f46dc3b2894d",
"assets/FontManifest.json": "d8392c03026ca6f703afef0d406e8fc9",
"assets/AssetManifest.bin.json": "ef76afde6bf863939d99b9014691fd99",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/hugeicons/lib/fonts/hugeicons-stroke-rounded.ttf": "85511f0673daae174f9e9f28a9e0c86e",
"assets/packages/easy_stepper/assets/loading_black.json": "d412b17ec906f03090996d68abab4eca",
"assets/packages/easy_stepper/assets/loading_white.json": "92623d18291ed579cf8bfe3f5fc74213",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "75c29e2b7999df049e271eff60a9c65a",
"assets/fonts/MaterialIcons-Regular.otf": "96ea3c59c1d56b7cc945ddd99b28d164",
"assets/assets/images/background/bg_pattern.png": "12dfab5f807b48f04a7bb256e7a7fcda",
"assets/assets/images/background/bg_screen_1.png": "66c09268dce1f2d913b938c3a8a1ad0b",
"assets/assets/images/background/bg_screen_2.png": "e7143bdb23309f664abc56309c6e9c96",
"assets/assets/images/logo/app_icon.png": "55f8d7c4dd3fd0a2d5fddd6818cfe9ba",
"assets/assets/images/gif/gif_send_2.gif": "e47842edf714a33fb54ef8b7a7176a47",
"assets/assets/images/gif/gif_success.gif": "eb0074f974d0c863c675bf48168bd8dd",
"assets/assets/images/gif/gif_send_3.gif": "85891a58642a169f83376ed77622bf78",
"assets/assets/images/gif/gif_send_1.gif": "37a1b5fac1860086483adfb7fbb68489",
"assets/assets/images/gif/gif_failed.gif": "1de62a7f198583efa85b94ec8e13aa85",
"assets/assets/images/gif/gif_payment.gif": "bfb087f54479a965882475226daaf3ff",
"assets/assets/images/gif/gif_empty.gif": "d5538281061dede7cda3c4b297895fb2",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
