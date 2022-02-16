(define (cddr s) (cdr (cdr s)))

(define (cadr s) (car (cdr s)))

(define (caddr s) (car (cddr s)))

(define (ordered? s)
    (if (or (null? s) (null? (cdr s)))
        #t
        (and (<= (car s) (cadr s)) (ordered? (cdr s)))
    )
)

(define (square x) (* x x))

(define (pow base exp)
    (cond
        ((= exp 0) 1)
        ((= exp 1) base)
        ((even? exp) (square (pow base (/ exp 2))))
        ((odd? exp) (* (square (pow base (quotient exp 2))) base))
    )
)
