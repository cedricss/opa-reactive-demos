module Thermostat {

    client function init(Dom.event _e) {

        temp = Reactive.value("50")

        function updated(_) {
            temp.set(Dom.get_value(#slider))
        }

        html =
            <h2>The current temperature is <code>{temp}</code> C</h2>
            <input id=#slider type="range" onchange={updated} />
            |> T.demo("Reactive Thermostat", _)

        #main = html
}

code = T.code_gist(4153803,"thermostat.opa")
}