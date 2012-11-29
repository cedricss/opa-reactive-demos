module Wiki {

    client function init(Dom.event _e) {

        wiki = Reactive.cloud_value("Enter some text...")

        function updated(_) {
            wiki.set(Dom.get_value(#text))
        }

        info =
            <ul>
            <li>The textarea and the preview block are automatically synchronized.</li>
            <li>Other browsers are also synchronized.</li>
            </ul>
            |> T.info

        demo =
            <h4>Edit</h4>
            <textarea style="width:100%;" rows="8" id=#text onkeyup={updated}>{wiki}</textarea>
            <h4>Preview</h4>
            <div class="well">{wiki}</div>
            |> T.demo("Wiki on the Cloud", _)

        html = <>{demo}</><>{info}</>

        #main = html
    }

code = T.code_gist(4153803,"wiki.opa")

}

