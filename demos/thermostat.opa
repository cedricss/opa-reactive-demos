module Thermostat {

    private temp = Reactive.make("50")

    function init(Dom.event _e) {
        void
    }

    private client function updated(Dom.event _e) {
        temp.set(Dom.get_value(#slider))
    }

    function html() {

        demo =
            <h2>The current temperature is <code>{temp}</code> C</h2>
            <input id=#slider type="range" onchange={updated} onkeyup={updated}/>
            |> T.demo("Reactive Thermostat", _)

        info =
            <ul>
            <li>The same reactive value is used both the server to compute the html, and on the client inside the timer.</li>
            <li>The reactive value can be declared and then used indifferently on the server or on the client side. It just works.</li>
            </ul>
            |> T.info

        <>{demo}{info}</>
    }

    code = T.code_gist(4153803,"thermostat.opa")

}