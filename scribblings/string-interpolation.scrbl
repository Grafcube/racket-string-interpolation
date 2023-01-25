#lang scribble/manual
@require[@for-label[string-interpolation]]

@title{string-interpolation}
@author{Grafcube}

@defmodule[string-interpolation]

Adds string interpolation syntax for all string literals.

@(define comment @hyperlink["https://news.ycombinator.com/item?id=14242481#14244305"]{@bold{this comment}})

Based on @|comment| but modified to include escape syntax.

@section[#:tag "usage"]{Usage}

Use racket in strings with the @code[#:lang "at-exp racket"]|{"@{<code>}"}| syntax.

@codeblock|{
#lang racket

(require string-interpolation)

(define (greet name) "Hello @{name}")
(greet "Racket")
}|

This results in @code[#:lang "at-exp racket"]|{"Hello Racket"}|.

You can escape this with the @code[#:lang "at-exp racket"]|{"@\\{<code>}"}| syntax.

@codeblock|{
#lang racket

(require string-interpolation)

(define (greet name) "Hello @\\{name}")
(greet "Racket")
}|

This results in @code[#:lang "at-exp racket"]|{"Hello @{name}"}|.
