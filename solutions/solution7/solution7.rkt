#lang racket

; Blatt 7 - Gebel, Schulte, Speck

; Aufgabe 1
(displayln "### Aufgabe 1 ###")
(displayln "")
;
;
; Wir definieren die range-Funktion:
;
; ..mittels normaler, rekursiver Funktion
(define (range tupel n)
   (if (>= (car tupel) (cdr tupel))
       '()
       (cons (car tupel) (range (cons (+ (car tupel) (/ (cdr tupel) n))  (cdr tupel)) n))
    )
  )

(displayln "-> normale, rekursive Funktion (range):")
(range '(0 . 10) 1)
(range '(0 . 10) 2)
(range '(0 . 10) 5)
(range '(0 . 10) 10)
(displayln "")

; ..mittels endrekursiver Funktion
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

(displayln "-> endrekursive Funktion (range2):")
(range2 '(0 . 10) 1)
(range2 '(0 . 10) 2)
(range2 '(0 . 10) 5)
(range2 '(0 . 10) 10)
(displayln "")

; ..mittels Funktion höherer Ordnung
(define (range3 tupel n)
  (build-list
   n
   (lambda (x) 
     (* x (/ (cdr tupel) n))
     )
   )
  )

(displayln "-> Funktion höherer Ordnung (range3):")
(range3 '(0 . 10) 1)
(range3 '(0 . 10) 2)
(range3 '(0 . 10) 5)
(range3 '(0 . 10) 10)
(displayln "")
