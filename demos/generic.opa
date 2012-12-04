// Template module
module T {
    function demo(title, xhtml) {
    	<section>
            <header><h1>{title}</h1></header>
            <div class="row-fluid">
            	{xhtml}
            	<br/><br/>
            </div>
        </section>
    }
    function loading_demo() {
        demo(<>&nbsp;</>, <div style="height:300px;"><h4>Fetching the demo...</h4></div><br/>)
    }
    function gist(id,filename) {
    	<gist data-id="{id}" data-file="{filename}">Loading
		<a href="https://gist.github.com/{id}#{filename}">{filename}</a>...</gist>
    }
    function code_gist(id,filename) {
		code_section(gist(id,filename))
	}
    function code_section(xhtml) {
		<section>
        <div class="sub-header"><h2><i class="icon-file"></i> Source Code</h2></div>
		<div class="row-fluid row-fluid-alternate-bg">
		{xhtml}
		</div>
		</section>
	}
    function info(xhtml) {
		<section>
        <div class="sub-header"><h2><i class="icon-info-sign"></i> Information</h2></div>
		<div class="row-fluid">{xhtml}</div>
		</section>
	}

}
