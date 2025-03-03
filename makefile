build : Main.elm
	elm make Main.elm --output main.js

debug : Main.elm
	elm make Main.elm --output main.js --debug

release : Main.elm
	elm make Main.elm --output main.js --optimize
	uglifyjs main.js --compress "pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe" | uglifyjs --mangle --output main.js
	mkdir -p releases
	zip releases/sobriscore-$(shell date +%Y%m%d).zip index.html main.js data.js main.css mvp.css sobriscore.svg logo_ecoco2_transparent.svg