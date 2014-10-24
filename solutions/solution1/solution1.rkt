#lang racket

; Aufgabe 1

;; Aufgabe 1.1

(define (deg2rad deg)
  (* deg (/ pi 180))
  )

(define (rad2deg rad)
  (* rad (/ 180 pi))
  )

;; Aufgabe 1.2

(define (my-acos cosX)
  (atan 
   (/ (sqrt (- 1 (sqr cosX))) cosX)
   )
  )
  
;; Aufgabe 1.3

(define (nm->km nm)
  (* nm 1.852)
  )


; Aufgabe 2

;; Aufgabe 2.1

;;; Großkreisentfernung im Bogenmaß, Parameter werden in Gradmaß übernommen
(define (GKE bgradA lgradA bgradB lgradB)
  (acos
   (+
   (* (sin (deg2rad bgradA))
      (sin (deg2rad bgradB)))
   (* (cos (deg2rad bgradA))
      (cos (deg2rad bgradB))
      (cos (deg2rad (- lgradA lgradB))))
   )
   )
  )

;;; Distanz in km zwischen zwei Orten A und B, Parameter werden in Gradmaß übernommen
(define (distanzAB bgradA lgradA bgradB lgradB)
  (nm->km 
   (* 
    (rad2deg (GKE bgradA lgradA bgradB lgradB))
    60)
   )
  )

;;; Distanzen ausgeben
(displayln "--- Aufgabe 2 ---")

(displayln "\n")

(displayln "Oslo nach Hongkong:")
(distanzAB 59.93 10.75 22.20 114.10)

(displayln "\n")

(displayln "San Francisco nach Honolulu:")
(distanzAB 37.75 -122.45 21.32 -157.83)

(displayln "\n")

(displayln "Osterinsel nach Lima")
(distanzAB -27.10 -109.40 -12.10 -77.05)
  
  
  
  
  