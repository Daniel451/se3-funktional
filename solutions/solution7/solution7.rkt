#lang racket

(define (range tupel n)
   (if (>= (car tupel) (cdr tupel))
       '()
       (cons (car tupel) (range (cons (+ (car tupel) (/ (cdr tupel) n))  (cdr tupel)) n))
    )
  )

(range '(0 . 10) 1)
(range '(0 . 10) 2)
(range '(0 . 10) 5)
(range '(0 . 10) 10)

(define (range2 tupel n [akku '()])
   (if (>= (car tupel) (cdr tupel))
       (reverse akku)
       (range2
        (cons 
         (+ (car tupel) (/ (cdr tupel) n))
         (cdr tupel)
         )
         n
         (cons (car tupel) akku))
    )
  )

(range2 '(0 . 10) 1)
(range2 '(0 . 10) 2)
(range2 '(0 . 10) 5)
(range2 '(0 . 10) 10)

(define (range3 tupel n)
  (build-list
   n
   (lambda (x) 
     (* x (/ (cdr tupel) n))
     )
   )
  )

(range3 '(0 . 10) 1)
(range3 '(0 . 10) 2)
(range3 '(0 . 10) 5)
(range3 '(0 . 10) 10)
