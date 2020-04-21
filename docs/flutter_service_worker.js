'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "412988e2ba91f9cdefd63bdc3f1cb5ca",
"/": "412988e2ba91f9cdefd63bdc3f1cb5ca",
"assets/assets/comps.png": "0664984f69c47aafa3c49bf9be3bb0cb",
"assets/assets/midpoint.png": "7b32f739142f7c17b124cf2fd7b10cd6",
"assets/assets/simps.png": "543167ddf79eb5d0f761fb5ebae8430b",
"assets/assets/trape.png": "9cb1f05d3c27f876660c46906a38869a",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/AssetManifest.json": "03c870df15123d0c6b8178aebdf5871b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/LICENSE": "a85811f3e3acea372195e4d6b68ed499",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"main.dart.js": "46b9f2d74a9e32b13e3f1f2e2c62c31f",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "fc9f9abb8a268d603a90d4a1960553c6",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
