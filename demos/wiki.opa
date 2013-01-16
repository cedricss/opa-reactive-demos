module Wiki {

    private exposed wiki = Reactive.make_sync(string "Enter some text...", "wiki")

    client function init(Dom.event _e) {

        wiki_textarea = wiki.render(
                { function(v) <textarea style="width:100%;"rows="8" id=#textclient1>{v}</textarea> }
        )


        function updated(dom)(Dom.event _e) {
            wiki.set(Dom.get_value(dom))
        }

        Reactive.bind(#textclient1, {keyup}, updated(#textclient1));

        demo =
            <h4>Edit</h4>
            <>{wiki_textarea}</>
            <h4>Preview</h4>
            <div class="well">{wiki}</div>
            |> T.demo("SERVER - Wiki on the Cloud", _)

        info =
            <ul>
            <li>The textarea and the preview block are automatically synchronized.</li>
            <li>Other browsers are also synchronized.</li>
            </ul>
            |> T.info

        #main = <>{demo}{info}</>

    }

    function html() {

        T.loading_demo()
    }

    code = T.code_gist(4153803,"wiki.opa")

}

