#lang racket

; Alexander Gebel, Britta Schulte, Daniel Speck

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
(displayln "--- Aufgabe 2.1 ---")

(displayln "\n")

(displayln "Oslo nach Hongkong:")
(distanzAB 59.93 10.75 22.20 114.10)

(displayln "\n")

(displayln "San Francisco nach Honolulu:")
(distanzAB 37.75 -122.45 21.32 -157.83)

(displayln "\n")

(displayln "Osterinsel nach Lima")
(distanzAB -27.10 -109.40 -12.10 -77.05)


;; Aufgabe 2.2
  
; berechnet den unnormierten Anfangskurs in Gradmaß, Parameter werden in Gradmaß übergeben
(define (AnfangskursUnnormiert bgradA lgradA bgradB lgradB)
 (rad2deg
  (acos
  (/
   (- 
    (sin (deg2rad bgradB))
    (* (cos (GKE bgradA lgradA bgradB lgradB)) (sin (deg2rad bgradA)))
    )
   (* (cos (deg2rad bgradA)) (sin (GKE bgradA lgradA bgradB lgradB)))
   )
  )
  )
)

(define (Anfangskurs bgradA lgradA bgradB lgradB richtung)
  (if (equal? richtung 'w)
      (- 360 (AnfangskursUnnormiert bgradA lgradA bgradB lgradB))
      (AnfangskursUnnormiert bgradA lgradA bgradB lgradB)
   )
  )
  
  
;;; Anfangskurs ausgeben
(displayln "\n")

(displayln "--- Aufgabe 2.2 ---")

(displayln "\n")

(displayln "Oslo nach Hongkong:")
(Anfangskurs 59.93 10.75 22.20 114.10 'o)

(displayln "\n")

(displayln "San Francisco nach Honolulu:")
(Anfangskurs 37.75 -122.45 21.32 -157.83 'w)

(displayln "\n")

(displayln "Osterinsel nach Lima")
(Anfangskurs -27.10 -109.40 -12.10 -77.05 'o)



;; Aufgabe 2.3.1
(define (Grad->Himmelsrichtung deg)
  (if (number? deg)
      (if (and (>= deg 0) (<= deg 360))
          (cond
            ((or (>= deg 348.75) (< deg 11.25)) 'N)
            ((< deg 33.75) 'NNE)
            ((< deg 56.25) 'NE)
            ((< deg 78.75) 'ENE)
            ((< deg 101.25) 'E)
            ((< deg 123.75) 'ESE)
            ((< deg 146.25) 'SE)
            ((< deg 168.75) 'SSE)
            ((< deg 191.25) 'S)
            ((< deg 213.75) 'SSW)
            ((< deg 236.25) 'SW)
            ((< deg 258.75) 'WSW)
            ((< deg 281.25) 'W)
            ((< deg 303.75) 'WNW)
            ((< deg 326.25) 'NW)
            ((< deg 348.75) 'NNW)
            )
          "Ungueltige Gradzahl - Eingabe muss im Interval [0, 360] liegen"
          )
      "Ungueltige Eingabe - Eingabe muss eine Zahl sein"
      )
  )


;; Aufgabe 2.3.2
(define (Himmelsrichtung->Grad him)
  (if (symbol? him)
      (cond
        ((equal? him 'N) 0)
        ((equal? him 'NNE) 22.5)
        ((equal? him 'NE) 45)
        ((equal? him 'ENE) 67.5)
        ((equal? him 'E) 90)
        ((equal? him 'ESE) 112.5)
        ((equal? him 'SE) 135)
        ((equal? him 'SSE) 157.5)
        ((equal? him 'S) 180)
        ((equal? him 'SSW) 202.5)
        ((equal? him 'SW) 225)
        ((equal? him 'WSW) 247.5)
        ((equal? him 'W) 270)
        ((equal? him 'WNW) 292.5)
        ((equal? him 'NW) 315)
        ((equal? him 'NNW) 337.5)
        )
      "Keine gueltige Himmelsrichtung"
      )
  )
