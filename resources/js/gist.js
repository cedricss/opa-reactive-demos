// Source: http://blog.jeansebtr.com/post/36590722386/async-loading-of-githubs-gists-without-jquery-31-loc
(function(){
    var gists = document.getElementsByTagName('gist');
    function embed(id, file, i, tag) {
        window['embed_gist_'+i] = function(gist) {
            var tmp = document.createElement('div');
            tmp.innerHTML = gist.div;
            tag.parentNode.replaceChild(tmp.firstChild, tag);
        };
        var url = 'https://gist.github.com/'+id+'.json?callback=embed_gist_'+i;
        if(file) {
            url += '&file='+file;
        }
        var script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = url;
        document.head.appendChild(script);
    }
    if(gists.length) {
        var css = document.createElement('link');
        css.rel = 'stylesheet';
        css.href= 'https://gist.github.com/stylesheets/gist/embed.css';
        document.head.appendChild(css);
    }
    for(var i=0; i<gists.length; i++) {
        var id = gists[i].getAttribute('data-id');
        var file = gists[i].getAttribute('data-file');
        if(id) {
            embed(id, file, i, gists[i]);
        }
    }
})();