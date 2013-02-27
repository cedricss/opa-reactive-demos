
module Basket {



    private function make_item(i,v) { { _id : "{i}", value : v } }

    //private exposed Reactive.list({ string _id, string value}) cloud_basket = Reactive.List.make_sync([], table_item, table_empty, "shopping-cart")

    client function init(Dom.event _e) {


        items_initial = [ "Interactive Drum T-Shirt", "USB Webcam Rocket Launcher", "Super Mario Bros Wall Decals", "Yoda Plush Backpack", "WoW Beer Stein", "Victorinox Secure Pro USB Drive"]
        items = items_initial ++ [ "iPhone App Magnets", "Lego Star Wars Alarm Clock", "Sudoku Toilet Paper", "Darth Vader Lightsaber", "Halo Helmet", "Star Wars Death Star Planetarium", "R2 D2 Trashcan", "Tetris Table", "Social Media Pillows", "The Wearable Keyboard", "The Darth Vader Toaster", "Lego Minifig Foosball Table", "IP Address Door Mat"]

        function table_empty() { <tr><td>Empty</td></tr> }
        function list_empty() { <li>No item</li> }
        function list_item(item) { <li class="flash">{item.value}</li> }

        recursive basket = Reactive.List.make([], table_item, table_empty)
        and function table_item(item) {
            pos = Int.of_string(item._id)
            id = "item-{pos}";
            Reactive.bind(#{id}, {click}, { function(_) basket.remove(item) })
            <tr><td class="flash">{item.value}</td><td><button id={id} class="btn btn-danger">Remove</button></td></tr> }

        basket_summary = Reactive.List.clone(basket, list_item, list_empty)

        function fill(_) {
            List.iteri({ function(i,v) basket.push(make_item(i,v)) },  items_initial)
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
                    <table class="table table-striped">{Reactive.list({ string _id, string value}) basket}</table>
                </div>
                <div class="span4">
                    <h4>Summary</h4>
                    <table class="table table-striped">{Reactive.list({ string _id, string value}) basket_summary}</table>
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