module Chat {

    private module Template {
        function table_empty() { <></> }
        function table_item(message) { <tr><td style="width:150px"><i class="icon-user"></i> {message.author}</td><td class="flash">{message.content}</td></tr> }
    }

    private function make_item(author,content) { { _id:Random.string(8), ~author, ~content } }
    private initial_messages = [ make_item("Robot", "Welcome on the chat."), make_item("Robot", "Post a new message now!") ]
    private exposed messages = Reactive.List.make_sync(initial_messages, Template.table_item, Template.table_empty, "chat-room")


    client function init(Dom.event _e) {


        // todo add message edition

        function post(_) {
           messages.push(make_item(Dom.get_value(#author),Dom.get_value(#message)))
           Scheduler.push({ function() Dom.scroll_to_bottom(#conversation) })
        }

        html =
            <div style="height:300px; overflow:auto" styleclass="row-fluid">
                <table class="table table-striped"><tbody>{messages}</tbody></table>
            </div>
            <div class="row-fluid">
                <div class="form-actions input-append">
                <input id=#author class="span2" type="text" value="Anonymous" placeholder="Author name"/>
                <input id=#message class="span8" type="text" placeholder="Enter a message" onnewline={post}/>
                <button class="btn" onclick={post}><i class="icon-share"></i> Post</button>
                </div>
            </div>
            |> T.demo("Chat", _)

        #main = html
    }

    function html() {
        T.loading_demo()
    }

    code = T.code_section(
            <>Todo</>
           ) //<>{T.gist(4153803,"shopping_cart.opa")}</>

}