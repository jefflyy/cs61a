(define (split-at lst n)
    (define (cat a l)
        (cons (cons a (car l)) (cdr l))
    )
    (cond
        ((null? lst) (cons nil nil))
        ((= n 0) (cons nil lst))
        (else (cat (car lst) (split-at (cdr lst) (- n 1))))
    )
)

(define (compose-all funcs)
    (if (null? funcs) (lambda (x) x)
        (lambda (x) ((compose-all (cdr funcs)) ((car funcs) x)))
    )
)
