# Description

Sobriscore is a series of quizzes designed for companies to test their maturity on the topic of sustainability. Quizzes are generated based on a JSON description, which can be validated using a provided JSON Schema - this makes it possible to generate complex quizzes simply by describing them.

The quizz generator has been prototyped using Elm, taking user feedback into account on very short cycles and can be used to build other quizzes.

Prototyped features for generated quizzes include :
- multi-sections quizz
- hierarchical questions : some questions activate only depending on previous answers
- different answer types : multiple common HTML inputs, Likert scales, radio+textfield,...
- custom scoring logic for each quizz
- complex feedback based on answers or answer combinations
- PDF report generation
- responsive design

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

# Demo

You can [try the prototype online](http://lleveque.github.io/sobriscore/) (in French).
