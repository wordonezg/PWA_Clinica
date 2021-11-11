let cacheData = "appV1"
this.addEventListener("install",(event)=>{
    event.waitUntil(
        caches.open(cacheData).then((cache)=>{
            cache.addAll([
                '/static/js/main.chunk.js',
                '/static/js/0.chunk.js',
                '/static/js/bundle.js',
                'static/js/vendors~main.chunk.js',
                '/index.html',
                '/',
                '/citas'
            ])
        })
    )
})

this.addEventListener("fetch",(event)=>{
    if(!navigator.onLine){
        event.respondWith(
            cache.match(event.request).then((resp)=>{
                if(resp){
                    return resp
                }
            })
        )
    }
})
