;; https://news.ycombinator.com/item?id=14242481#14244305

#lang racket

(require
  (rename-in racket (#%datum core-datum))
  (for-syntax syntax/parse))

(define-syntax (#%datum stx)
  (syntax-parse stx
    [(_ . x:str) (interpolate #'x)]
    [(_ . x)     #'(core-datum . x)]))

(define-for-syntax (interpolate stx)
  (define re            #rx"@[^\\]?{[^}]+}")
  (define (trim match)  (substring match 2 (- (string-length match) 1)))
  (define (to-stx val)  (datum->syntax stx val))
  (define (datum val)   (to-stx (cons #'core-datum val)))
  (define (source text) (to-stx (read (open-input-string text))))
  (define (unescape text) (regexp-replace #rx"@\\\\{" text "@{"))
  (let* ([text     (syntax->datum stx)]
         [matches  (regexp-match* re text)]
         [template (datum (unescape (regexp-replace re text "~a")))]
         [values   (map (compose source trim) matches)])
    (if (null? matches)
        template
        (to-stx `(,#'format ,template ,@values)))))

(provide #%datum)

(module+ test
  (require rackunit)
  (define answer 42)
  (check-equal? "What's the answer? 42" "What's the answer? @{answer}")
  (check-equal? "4 + 2 = 6" "4 + 2 = @{(+ 4 2)}"))
