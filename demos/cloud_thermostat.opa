type temperature = {int value, int min, int max}
@xmlizer(temperature) function temp_to_html(t){
    <>{t.value}</>
}

module CloudThermostat {

    client function init(Dom.event _e) {

        temperature initial_temp = {value:50, min:0, max:100}
        Reactive.value(temperature) temp = Reactive.make(initial_temp).sync("thermostat")

        function updated(Dom.event _e) {
            temp.set({value:Int.of_string(Dom.get_value(#slider)), min:0, max:100})
        }

        Reactive.bind(#slider, {change}, updated);

        temp_slider = Reactive.render(
            { function(_)
                t = temp.get();
                <input id=#slider type="range" min={t.min} max={t.max} value={t.value}/> }
        )(temp)

        demo =
            <h2>The current temperature is <code>{temp}</code> C</h2>
            <>{temp_slider}</>
            |> T.demo("Remote Thermostat", _)

        info =
            <ul>
            <li>Open another browser tab and move the slider: the sliders are all synchronized!</li>
            </ul>
            |> T.info

        #main = <>{demo}</><>{info}</>
    }

    function html() {
        T.loading_demo()
    }

    code = T.code_section(
        <>Todo</>
        ) // 4153803,"thermostat.opa"

}