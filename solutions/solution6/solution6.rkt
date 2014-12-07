#lang racket

; Blatt 6 - Gebel, Schulte, Speck

(require 2htdp/image)
(require racket/trace)


; Aufgabe 1


;; Definition von Rekursionstypen:

;;; * Linerare Rekursion:
;;;   Eine Funktionsdefinition, die sich auf der rechten Seite
;;;   der definierenden Gleichung in jeder Fallunterscheidung
;;;   selbst nur einmal verwendet, heißt linear-rekursiv.

;;; * Baum Rekursion:
;;;   Eine rekursive Definition ist baumartig
;;;   wenn in der Definition in einer
;;;   Fallunterscheidung mehrfach auf die
;;;   Definition Bezug genommen wird.

;;; * Geschachtelte Rekursion:
;;;   Eine Rekursion ist geschachtelt, wenn die Funktion in der
;;;   rekursiven Verwendung selbst als Argument mitgegeben
;;;   wird.

;;; * Direkte Rekursion:
;;;   Wenn ein rekursives Element direkt auf sich verweist bzw. eine Funktion sich selbst aufruft, spricht man von direkter Rekursion.

;;; * Indirekte Rekursion:
;;;   Eine rekursive Definiton heißt indirekt oder verschränkt,
;;;   wenn zwei oder mehrere Definitionen sich wechselseitig
;;;   rekursiv verwenden.



;; Angaben zu den einzelnen Funktionen:

;; Kopfstück
;;;
;;; lineare Rekursion, da die Funktion nur einmalig im rechten Teil des else-cases aufgerufen wird











; Aufgabe 2

;; Gibt die Länge einer Liste zurück
(define (laengeListe liste)
  (if
   (null? liste)
   0
   (+ 1 (laengeListe (cdr liste)))
   )
  )


;; Gibt eine Zufallszahl zurück, die kleiner als n ist
(define (Zufallszahl n)
  (modulo
   (+
    (modulo (+ (random n) (random (+ n 1)) (random (round (/ n 2)))) n)
    (modulo (* (random n) (random (+ n 1)) (random (round (/ n 2)))) n)
    )
   n
   )
  )


;; Gibt eine Zufallsfarbe zurück
(define (Zufallsfarbe)
  (let (
        [Farben 
         (list "blue" "green" "orange" "brown" "yellow" "cyan" "firebrick" "violet red" "orchid" "coral"
                      "gold" "olive" "wheat" "darkgreen" "lime" "aquamarine" "royalblue" "skyblue" "navy" "purple")]
        )
    (let gibFarbe (
                   [n 1]
                   [element (+ 1 (Zufallszahl (laengeListe Farben)))]
                   [farbe Farben]
                   )
      (cond
        [(= n element)
         (car farbe)]
        [(< n element)
         (gibFarbe (+ n 1) element (cdr farbe))
         ]
        )
      )
    )
  )


;; Einen Geschenkebaum zeichnen
;;; ebene: 1-5
;;; ausrichtung: "left", "right", "center"
(define (Geschenkebaum ebene ausrichtung)
  (cond
    [(> ebene 1)
     (above/align ausrichtung
                  (overlay/align "middle" "middle"
                                 (rectangle (* 80 (expt 0.7 ebene)) 5 "solid" "red")
                                 (rectangle 5 (* 80 (expt 0.7 ebene)) "solid" "red")
                                 (rectangle (* 80 (expt 0.7 ebene)) (* 80 (expt 0.7 ebene)) "solid" (Zufallsfarbe)))
                  (Geschenkebaum (- ebene 1) ausrichtung)
                  )]
    [(= ebene 1)
     (overlay/align "middle" "middle"
                    (rectangle 90 5 "solid" "red")
                    (rectangle 5 50 "solid" "red")
                    (rectangle 90 50 "solid" (Zufallsfarbe)))
     ]
    )
  )


;; Weihnachtsbaum zeichnen
(define (Weihnachtsbaum ebenen groesse farbe)
  (let zeichneBaum ([ebene 1])
    (cond 
      [(= ebene ebenen)
       (radial-star 6 6 25 "solid" "gold")
       ]
      [(and (>= ebene 1) (< ebene ebenen))
       (overlay/offset
        (triangle (* groesse (expt 0.85 (- ebene 1))) "solid" farbe)
        0 (* -35 (expt 0.9 (- ebene 1)))
        (zeichneBaum (+ ebene 1))
        )
       ]
      )
    )
  )


;; Weihnachtsbild zeichen
(define (Weihnachtsbild)
  (above/align "center"
               (beside/align "bottom"
                             (Weihnachtsbaum 6 80 "darkgreen")
                             (Geschenkebaum 5 "center")
                             (Weihnachtsbaum 8 120 "darkgreen")
                             (Geschenkebaum 5 "center")
                             (Weihnachtsbaum 6 80 "darkgreen")
                             )
               (text "Frohe Weihnachten" 32 "black")
               )
  )


;; Weihnachtsbild automatisch zeichnen
(Weihnachtsbild)