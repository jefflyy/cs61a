(define (my-filter func lst)
    (cond
        ((null? lst) nil)
        ((func (car lst)) (cons (car lst) (my-filter func (cdr lst))))
        (else (my-filter func (cdr lst)))
    )
)

(define (interleave s1 s2)
    (cond
        ((null? s1) s2)
        ((null? s2) s1)
        (else (cons (car s1) (cons (car s2) (interleave (cdr s1) (cdr s2)))))
    )
)

(define (accumulate merger start n term)
    (if (= n 0)
        start
        (accumulate merger (merger (term n) start) (- n 1) term)
    )
)

(define (no-repeats lst)
    (cond
        ((null? lst) nil)
        ((null? (my-filter (lambda (x) (= (car lst) x)) (cdr lst))) (cons (car lst) (no-repeats (cdr lst))))
        (else (no-repeats (cdr lst)))
    )
)
