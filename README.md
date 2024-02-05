# Building

Run `make`, `make debug` or `make release` according to your needs.

## Standard build

`make` will output `main.js`, that is loaded by `index.html`. Nothing is optimized/minified, symbols are accessible.

## Debug build

`make debug` will output a `main.js` that includes the Elm interactive, time-travelling debugger.

## Release build

`make release` produces an optimized and minified version of `main.js`

# Running

Run a static http server in the local folder such as `python3 -m http.server`. You can also browse `index.html` directly but it will fail if we try to fire http requests.