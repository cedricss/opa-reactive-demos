
module Basket {

    client private module Template {
        function table_empty() { <tr><td>Empty</td></tr> }
        function table_item(item) { <tr><td class="flash">{item.value}</td></tr> }
        function list_empty() { <li>No item</li> }
        function list_item(item) { <li class="flash">{item.value}</li> }
    }

    private function make_item(i,v) { { _id : "{i}", value : v } }

    client function init(Dom.event _e) {

        basket = Reactive.List.make([], Template.table_item, Template.table_empty)
        basket_summary = Reactive.List.clone(basket, Template.list_item, Template.list_empty)
        items_initial = [ "Interactive Drum T-Shirt", "USB Webcam Rocket Launcher", "Super Mario Bros Wall Decals", "Yoda Plush Backpack", "WoW Beer Stein", "Victorinox Secure Pro USB Drive"]
        items = items_initial ++ [ "iPhone App Magnets", "Lego Star Wars Alarm Clock", "Sudoku Toilet Paper", "Darth Vader Lightsaber", "Halo Helmet", "Star Wars Death Star Planetarium", "R2 D2 Trashcan", "Tetris Table", "Social Media Pillows", "The Wearable Keyboard", "The Darth Vader Toaster", "Lego Minifig Foosball Table", "IP Address Door Mat"]
        function fill(_) {
            List.iteri({ function(i,v) basket.add(make_item(i,v), i) },  items_initial)
        }
        function random() {
            cart_pos = Random.int(List.length(items_initial))
            item_pos = Random.int(List.length(items))
            item = { _id : "{cart_pos}", value : List.unsafe_get(item_pos, items) }
            basket.change(item, cart_pos)
        }
        function infinite(_) {
            Scheduler.timer(500, random)
        }
        html =
            <div style="height:300px" class="row-fluid">
                <div class="span8">
                    <h4>My items</h4>
                    <table class="table table-striped">{basket}</table>
                </div>
                <div class="span4">
                    <h4>Summary</h4>
                    <ul>{basket_summary}</ul>
                </div>
            </div>
            <div class="row-fluid">
                <div class="form-actions">
                <button class="btn" onclick={fill}><i class="icon-circle-arrow-down"></i> Fill my cart</button>
                <button class="btn" onclick={ function(_) random() }><i class="icon-refresh"></i> Random updates</button>
                <button class="btn" onclick={ infinite }><i class="icon-play"></i> Infinite updates</button>
                </div>
            </div>
            |> T.demo("Shopping Cart", _)

        #main = html
    }

    function html() {
        T.loading_demo()
    }


    code = T.code_section(
            <>{T.gist(4153803,"shopping_cart.opa")}</>
            <>{T.gist(4153803,"template.opa")}</>
           )

}