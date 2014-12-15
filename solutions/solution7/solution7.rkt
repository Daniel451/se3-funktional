#lang racket
(require 2htdp/image)

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




; Aufgabe 2

(displayln "")
(displayln "### Aufgabe 2 ###")
(displayln "")


;; Aufgabe 2.1

(define (function->points function interval n)
  (map
   (lambda (x y) (cons x y))
   (range3 interval n)
   (map function (range3 interval n))
   )
  )

(displayln "> Aufgabe 2.1")
(function->points sqr '(0 . 10) 5)
(displayln "")


;; Aufgabe 2.2


;; Paar-zu-Liste konvertieren
(define (pair->list pair)
    (cons (car pair) (cons (cdr pair) '()))
)

;; gib Minimum von einer Liste zurück
(define (listMin lst)
    (foldl min (car lst) lst)
 )

;; gib Maximum von einer Liste zurück
(define (listMax lst)
    (foldl max (car lst) lst)
 )

;; Gibt eine Funktion zurück, die einen Anteil berechnet. 
;; Das Listen-Minimum wird von dem eingegebenen x subtrahiert (um Werte im Interval von 0-1 zu erzeugen)
;; und durch die Differenz von Maximum und Minimum (Schrittweite) geteilt.
(define (funcNormalize lst)
  (lambda (x)
   (/ (- x (listMin lst)) (- (listMax lst) (listMin lst)))
   ))

;; Gibt eine Funktion zurück, die den berechneten Anteil auf das neue Intervall umrechnet.
;; Die Schrittweite des Intervalls wird mal x (den vorher berechneten Anteil) genommen und plus das Minimum genommen,
;; um die Anteile auf das neue Intervall umzurechnen.
(define (funcProjection intervall)
  (lambda (x) 
    (+ 
     (* 
      (- (listMax (pair->list intervall))
         (listMin (pair->list intervall)))
      x)
     (listMin (pair->list intervall)))))


; Funktion für den ein-dimensionalen Fall:
; Erst werden die Anteile berechnet, indem mit map die funcNormalize Funktion auf die Liste angewendet wird.
; Dann wird mit map die Funktion funcProjection auf die eben erzeugte "normalisierte" Liste angewendet, sodass
; die umgerechnete Liste ausgegeben wird.
(define (rescale1d lst interval)
  (map (funcProjection interval) (map (funcNormalize lst) lst))
)

; Funktion für den zweidimensionalen Fall:
; Wir benutzen einfach rescale1d mit map für (car lst) bzw. (cdr lst)
(define (rescale2d lst interval1 interval2)
    (map
     (lambda (x y) (cons x y))
     (rescale1d (map car lst) interval1)
     (rescale1d (map cdr lst) interval2)
     )
 )


(displayln "> Aufgabe 2.2 | eindimensional")
(rescale1d '(0 2 4 6 8) '(10 . 50))
(displayln "")
(displayln "> Aufgabe 2.2 | zweidimensional")
(rescale2d 
    '((0 . 0) (2 . 4) (4 . 16) (6 . 36) (8 . 64))
    '(10 . 50)
    '(5 . 25))





; Gibt eine Funktion zurück, die einen Punkt grafisch darstellt.
;(define (get-x pointlist)
  ;(car (get-independent-lists (rescale2d pointlist '(0 600) '(0 800)))))

;(define (get-y pointlist)
   ;(cadr (get-independent-lists (rescale2d pointlist '(0 600) '(0 800)))))

(define (draw-points pointlist)
  (map (lambda (x y) 
         (place-image 
           (ellipse 30 60 "solid" "blue")
           x y
           (rectangle 600 800 "solid" "white")))
       (map (lambda (x) (car x)) pointlist)
       (map (lambda (x) (cdr x)) pointlist)
         ))

(displayln "")
(displayln "> Aufgabe 2.3 | zweidimensional")
(draw-points (rescale2d '((0 . 0) (2 . 4) (4 . 16) (6 . 36) (8 . 64)) '(10 . 50) '(5 . 25)))


