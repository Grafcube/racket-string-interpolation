# string-interpolation for Racket

This package adds string interpolation to Racket string literals.

Based on [this comment](https://news.ycombinator.com/item?id=14242481#14244305).
Modified to also have escape syntax.

Use racket in strings with the `"@{<code>}"` syntax.

```racket
#lang racket

(require string-interpolation)

(define (greet name) "Hello @{name}")
(greet "Racket")
```

This results in `"Hello Racket"`.

You can escape this with the `"@\{<code>}"` syntax.

```racket
#lang racket

(require string-interpolation)

(define (greet name) "Hello @\\{name}")
(greet "Racket")
```

This results in `"Hello @{name}"`.
