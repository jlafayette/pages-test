@echo off
call mkdir "build"
call elm make src\Main.elm --output build\elm.js
call uglifyjs build\elm.js --compress "pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe" --output build\elm.js
call uglifyjs build\elm.js --mangle --output docs\elm.min.js
call rmdir "build" /S /Q