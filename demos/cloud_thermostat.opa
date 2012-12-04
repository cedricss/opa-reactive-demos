module CloudThermostat {


    function init(Dom.event _e) {

        temp = Reactive.make("50") // coming soon: |> Reactive.to_cloud_value

        function updated(Dom.event _e) {
            temp.set(Dom.get_value(#slider))
        }

        temp_slider = temp.render(
            { function(v) <input id=#slider type="range" value={temp.get()}/> }
        )

        Reactive.bind(#slider, {change}, updated);

        demo =
            <h2>The current temperature is <code>{temp}</code> C</h2>
            <>{temp_slider}</>
            |> T.demo("Remote Thermostat", _)

        info =
            <ul>
            <li>The same reactive value is used both the server to compute the html, and on the client inside the timer.</li>
            <li>The reactive value can be declared and then used indifferently on the server or on the client side. It just works.</li>
            </ul>
            |> T.info

        #main = <>{demo}{info}</>

    }

    function html() {

        T.loading_demo()
    }

    code = T.code_gist(4153803,"thermostat.opa")

}