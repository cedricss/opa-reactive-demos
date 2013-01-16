import stdlib.themes.bootstrap.icons
import stdlib.meteor.spark10

function get_demo(url) {
    match(url) {
    case "thermostat" : Thermostat
    case "shopping" : Basket
    case "wiki" : Wiki
    case "cloud-thermostat" : CloudThermostat
    case "chat" : Chat
    default : Thermostat
    }
}

function selected(url,v) {
    if (url == v) { [ "selected" ] }else{ [] }
}

function white(url,v) {
    if (url != v) { "icon-white" }else{ "" }
}

function link(url, page, icon, text) {
    <li class={ selected(url,page) }>
        <a href="/{page}"><i class="icon-{icon} {white(url,page)}"></i> {text}</a>
    </li>
}

function page(url) {
    D = get_demo(url)
    l = link(url,_,_,_)
    <div class="navbar navbar-static-top navbar-inverse">
      <div class=navbar-inner>
        <div class=container>
          <a class="brand" href="./index.html">Opa Reactive Demos</a>
          <div id="buttons"/>
        </div>
      </div>
    </div>
    <div class="container">
    <div class="row-fluid">
        <div class="span3">
            <aside>
                <nav>
                    <ul class="nav">
                      {l("thermostat", "fire", "Reactive Thermostat")}
                      {l("cloud-thermostat", "globe", "Remote Thermostat")}
                      {l("wiki", "font", "Wiki on the Cloud")}
                      {l("shopping", "shopping-cart", "Shopping Cart")}
                      {l("chat", "comment", "Chat")}

                    </ul>
                </nav>
            </aside>
        </div>
        <div class="span9" id="content-wrapper">
            <div id="content">
            <div id=#main onready={D.init}>{D.html()}</div>
            {D.code}
        </div>
    </div>
    </div>
    </div>
    <footer>
        <div class="container">
        <p>Demos designed and built at <a href="http://opalang.org">Opalang</a> by <a href="https://github.com/littke/cedricss">Cédric Soulas</a>.</p>
        <p>Bootstrap theme by Jonatan Littke: <a href="https://github.com/littke/inspiritas-bootstrap">Inspiritas</a>.</p>
        <p>Code licensed under MIT. <a href="https://github.com/cedricss/opa-reactive-demos">Source code on Github.</a></p>
        </div>
    </footer>
}

dispatcher = parser {
case "/" : Resource.default_redirection_page("/thermostat")
case "/code/" name=(.*) : Resource.page("", <script src="https://gist.github.com/4153803.js?file={Text.to_string(name)}.opa"></script>)
case "/" path=(.*) : Resource.page("", page(Text.to_string(path)))
default : Resource.page("", page("/"))
}

Server.start(
    Server.http,
    [

        {register : [ { doctype : { html5 } }, { js : [ "resources/js/gist.js", "resources/js/html5slider.js" ] }, { css : [ "/resources/css/style.css", "/resources/inspiritas/inspiritas.css" ]} ] },
        {resources:@static_resource_directory("resources") },
        {custom:dispatcher}
    ]
)
