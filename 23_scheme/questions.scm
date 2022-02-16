(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
    ; BEGIN PROBLEM 15
    (define (label s n)
        (if (null? s) nil
            (cons (list n (car s)) (label (cdr s) (+ n 1)))
        )
    )
    (label s 0)
)
; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to INORDER? and return
;; the merged lists.
(define (merge inorder? list1 list2)
    ; BEGIN PROBLEM 16
    (cond
        ((null? list1) list2)
        ((null? list2) list1)
        ((inorder? (car list1) (car list2)) (cons (car list1) (merge inorder? (cdr list1) list2)))
        (else (cons (car list2) (merge inorder? list1 (cdr list2))))
    )
)
; END PROBLEM 16


;; Optional Problem 1

;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda

(define (cat2 a b l)
    (list
        (cons a (car l))
        (cons b (cadr l))
    )
)

(define (unzip l)
    (if (null? l) (list nil nil)
        (cat2 (car (car l)) (car (cdar l)) (unzip (cdr l)))
    )
)

(define (let-to-lambda expr)
    (define (listltl l)
               (if (null? l) nil
                   (cons (let-to-lambda (car l)) (listltl (cdr l)))
               )
           )
  (cond ((or (atom? expr) (quoted? expr) (procedure? expr))
         expr
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           (cons form (cons params (listltl body)))
           ))
        ((let? expr)
         (let ((values (unzip (cadr expr)))
               (body   (cddr expr)))
           (cons (cons 'lambda (cons (car values) (listltl body))) (listltl (cadr values)))
           ))
       ((list? expr)
               (listltl expr)
        )
        (else
         expr
         )))



;; Problem 21 (optional)
;; Draw the hax image using turtle graphics.
(define (hax d k)
  ; BEGIN Question 21
  'replace-this-line
  )
  ; END Question 21