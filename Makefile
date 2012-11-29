OPA ?= opa

demo.js: resources/css/style.css demo.opa demos/*.opa
	$(OPA) demos/*.opa demo.opa

run: demo.js
	./demo.js