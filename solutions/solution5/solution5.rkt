#lang racket


; Blatt 4 - Gebel, Schulte, Speck

; require
(require "butterfly-module-2013.rkt") ; relatives require (file muss in aktuellem dir liegen)
(require 2htdp/image)

; defines
(define size 100)
(define kopfbreite (/ size 7))
(define bodycolor 'black)



; Aufgabe 1 Mendels Land

;; Es lassen sich 4 Typnen von Merkmalen unterscheiden:
;;; * Musterung: Schwarze Sterne, Punkte oder Streifen
;;; * Flügelfarbe: rot, gelb oder blau
;;; * Fühlerform: gerade, gekrümmt, gewellt
;;; * Flügelform: rhombisch, elliptisch, sechseckig

;; Jeder Schmetterling trägt pro Merkmalstyp ein dominantes und ein rezessives Merkmal

;; Es gelten folgende Dominanzregeln:
;;; * blau > gelb > rot
;;; * Streifen > Punkte > Sterne
;;; * Gekrümmte Fühler > Gerade Fühler > Gewellte Fühler
;;; * Sechseckige Flügel > Rhombische Flügel > Elliptische Flügel


;; 1.1 Analyse und Beschreibung der Teilprobleme

;;; Die einzelnen Eigenschaften müssen in geeignete Datenstrukturen überführt werden, es werden
;;; mehrere Funktionen benötigt, um zwei Tiere zu paaren und andere Operationen auszuführen. Die Mendelsche
;;; Vererbung muss korrekt angewendet werden (Vorrang von einigen Erbeigenschaften gegenüber anderen).

;; Teilprobleme:
;;; - Listen für die Merkmale erstellen
;;; - Vorrang von Erbeigenschaften überprüfen
;;; - Hinzufügung von zufälligen, konsistenten, rezessiven Merkmalen
;;; - Bestimmung von rezessiven Merkmalen
;;; - Eine Funktion zum Paaren von Tieren

;; 1.2 Vorschlag zur Gliederung des Programms in Funktionen, Spezifikation und Dokumentation der Schnittstellen
;;; - Musterung (Liste mit Merkmalen, höhere Werte = höhere Präzedenz)
;;; - Flügelfarbe (Liste mit Merkmalen, höhere Werte = höhere Präzedenz)
;;; - Fühlerform (Liste mit Merkmalen, höhere Werte = höhere Präzedenz)
;;; - Flügelform (Liste mit Merkmalen, höhere Werte = höhere Präzedenz)
;;; - Dominanz (Dominanz von zwei Ausprägungen eines Merkmals feststellen)
;;; - Rezessiv (Ein zufälliges rezessives Merkmal hinzufügen)
;;; - Zufall (Aus zwei Ausprägungen eine Zufallsausprägung zurückgeben)
;;; - Kindermachen (Berechnung der Kunder zweier Elterntiere)
;;; - Paarung (Funktion für die Paarung zweier Tiere)



;; 1.3 Implementation

;;; Wir erstellen für jedes Merkmal eine eigene Liste mit Tupeln, 
;;; in denen jeder Ausprägung ein Wert zugewiesen wird. 
;;; Aufsteigend von rezessiv nach dominant. Je höher der Wert, desdo dominanter das Merkmal


; blau > gelb > rot
(define Flügelfarbe
  (list (cons 'red 1)
        (cons 'yellow 2)
        (cons 'blue 3)))

; Streifen > Punkte > Sterne
(define Musterung 
  (list (cons 'star 1)
        (cons 'dots 2)
        (cons 'stripes 3)))

; Gekrümmte Fühler > Gerade Fühler > Gewellte Fühler
(define Fühlerform
  (list (cons 'curly 1)
        (cons 'straight 2)
        (cons 'curved 3)))

; Sechseckige Flügel > Rhombische Flügel > Elliptische Flügel
(define Flügelform
  (list (cons 'ellipse 1)
        (cons 'rhomb 2)
        (cons 'hexagon 3)))



;; Funktion zur Prüfung welche Ausprägung die höhere Dominanz hat. 
;;; Wenn beide Ausprägungen gleich dominant sind, soll das erste genommen werden
;;; Wenn die erste Auprägung einen höheren Dominanzwert hat, soll diese genommen werden
;;; Sonst ist die zweite Ausprägung dominanter
;;;
;;; racket doc zu assoc: Sucht in einer Liste nach einer Subliste oder einem Tupel, dessen
;;; erster Eintrag das gesuchte Element enthält und gibt den ersten Fund komplett zurück.
;;; (assoc 'yellow Flügelfarbe) z.B. liefert '(yellow . 2)

(define (Dominanz Ausprägung1 Ausprägung2 Merkmal)
  (cond
    ; gleiche Dominanz
    [(= (cdr (assoc Ausprägung1 Merkmal)) (cdr (assoc Ausprägung2 Merkmal)))
     Ausprägung1]
    ; Ausprägung1 > Ausprägung2
    [(> (cdr (assoc Ausprägung1 Merkmal)) (cdr (assoc Ausprägung2 Merkmal)))
     Ausprägung1]
    [else
     Ausprägung2
     ]
    )
  )



;; Funktion um zu einem dominanten Merkmal ein zufälliges rezessives Merkmal herauszusuchen.
;;; Wenn die übergebene Ausprägung den Wert 1  hat, wird die selbe Ausprägung ausgegeben
;;; Sonst wird eine zufällige Zahl von 0 bis zur Merkmalszahl gewählt
;;; und das Merkmal mit der Position in der Liste ausgegeben
;;;
;;; racket doc zu list-ref: (list-ref list i) gibt das i-te Element aus list zurück
;;; Listenindex beginnt bei 0

(define (GetRezessiv Ausprägung Merkmal)
  ; Merkmal suchen
  (if (= (cdr (assoc Ausprägung Merkmal)) 1)
      Ausprägung ; Merkmal hat schon niedriegste Präzedenz, also einfach Merkmal zurückgeben
      ; Zufälliges Merkmal mit geringerer Präzedenz suchen
      (car (list-ref Merkmal (random (cdr (assoc Ausprägung Merkmal)))))
      ))



;; Funktion, die von zwei übergebenen Ausprägungen zufällig eine auswählt und zurückgibt

(define (Zufall Ausprägung1 Ausprägung2)
  
  ; sorgt für eine bessere Zufallsverteilung, zumindest bei unseren Versuchen
  ; hat (random 2) für das Interval [0,1] nicht so gut funktioniert
  ; (Werte waren teilweise 5-6x hintereinander gleich, was natürlich zu gleichartigen Schmetterlingen führt)
  (if (= (modulo (random 100) 2) 1)
      Ausprägung1
      Ausprägung2))



;; Kinder erzeugen
;; Berechnung und Darstellung der Kinder.

(define (Kindermachen
                 Flügelfarbe_Mutter Flügelfarbe_Mutter_Rez
                 Musterung_Mutter Musterung_Mutter_Rez
                 Fühlerform_Mutter Fühlerform_Mutter_Rez
                 Flügelform_Mutter Flügelform_Mutter_Rez
                 
                 Flügelfarbe_Vater Flügelfarbe_Vater_Rez
                 Musterung_Vater Musterung_Vater_Rez
                 Fühlerform_Vater Fühlerform_Vater_Rez
                 Flügelform_Vater Flügelform_Vater_Rez
                 
                 Anzahl_Kinder counter)
  
  (if (not (= counter Anzahl_Kinder))
     (beside
       (above (scale 0.5 
                     
                     (show-butterfly (Dominanz (Zufall Flügelfarbe_Mutter Flügelfarbe_Mutter_Rez)
                                               (Zufall Flügelfarbe_Vater Flügelfarbe_Vater_Rez)
                                               Flügelfarbe)
                                     (Dominanz (Zufall Musterung_Mutter Musterung_Mutter_Rez)
                                               (Zufall Musterung_Vater Musterung_Vater_Rez)
                                               Musterung)
                                     (Dominanz (Zufall Fühlerform_Mutter Fühlerform_Mutter_Rez)
                                               (Zufall Fühlerform_Vater Fühlerform_Vater_Rez)
                                               Fühlerform)
                                     (Dominanz (Zufall Flügelform_Mutter Flügelform_Mutter_Rez)
                                               (Zufall Flügelform_Vater Flügelform_Vater_Rez)
                                               Flügelform)))
              
              (text "Kind" 14 'black))
       
       (rhombus (/ size 10) 90 'outline 'orange)
       
       (Kindermachen Flügelfarbe_Mutter Flügelfarbe_Mutter_Rez Musterung_Mutter Musterung_Mutter_Rez
                Fühlerform_Mutter Fühlerform_Mutter_Rez Flügelform_Mutter Flügelform_Mutter_Rez
                Flügelfarbe_Vater Flügelfarbe_Vater_Rez Musterung_Vater Musterung_Vater_Rez
                Fühlerform_Vater Fühlerform_Vater_Rez Flügelform_Vater Flügelform_Vater_Rez Anzahl_Kinder (+ 1 counter)
                )
       )
      
      (above (scale 0.5 
                    (show-butterfly (Dominanz (Zufall Flügelfarbe_Mutter Flügelfarbe_Mutter_Rez)
                                              (Zufall Flügelfarbe_Vater Flügelfarbe_Vater_Rez) Flügelfarbe)
                                    (Dominanz (Zufall Musterung_Mutter Musterung_Mutter_Rez)
                                              (Zufall Musterung_Vater Musterung_Vater_Rez) Musterung)
                                    (Dominanz (Zufall Fühlerform_Mutter Fühlerform_Mutter_Rez)
                                              (Zufall Fühlerform_Vater Fühlerform_Vater_Rez) Fühlerform)
                                    (Dominanz (Zufall Flügelform_Mutter Flügelform_Mutter_Rez)
                                              (Zufall Flügelform_Vater Flügelform_Vater_Rez) Flügelform)))
             (text "Kind" 14 'black))
      )
  )



;; Paarung
;;; Übergabe der Eltern-Parameter und bestimmen der rezessiven Merkmale. 
;;; Darstellung der Eltern via "show-butterfly".


(define (Paarung 
              Flügelfarbe_Mutter
              Flügelfarbe_Vater
              
              Musterung_Mutter
              Musterung_Vater
              
              Fühlerform_Mutter
              Fühlerform_Vater
              
              Flügelform_Mutter
              Flügelform_Vater
              
              Anzahl_Kinder)
  
  (let
      (
       (Flügelfarbe_Mutter_Rez (GetRezessiv Flügelfarbe_Mutter Flügelfarbe))
       (Flügelfarbe_Vater_Rez (GetRezessiv Flügelfarbe_Vater Flügelfarbe))
       (Musterung_Mutter_Rez (GetRezessiv Musterung_Mutter Musterung))
       (Musterung_Vater_Rez (GetRezessiv Musterung_Vater Musterung))       
       (Fühlerform_Mutter_Rez (GetRezessiv Fühlerform_Mutter Fühlerform))
       (Fühlerform_Vater_Rez (GetRezessiv Fühlerform_Vater Fühlerform))
       (Flügelform_Mutter_Rez (GetRezessiv Flügelform_Mutter Flügelform))
       (Flügelform_Vater_Rez (GetRezessiv Flügelform_Vater Flügelform))
       )
    
    (beside     
     ; Zeige Mutter Schmetterling 
     (above (show-butterfly Flügelfarbe_Mutter Musterung_Mutter Fühlerform_Mutter Flügelform_Mutter)
            (text "Mutter" 14 'black))
     
     (rhombus (/ size 10) 90 'outline 'orange)
     
     ; Zeige Vater Schmnetterling 
     (above (show-butterfly Flügelfarbe_Vater Musterung_Vater Fühlerform_Vater Flügelform_Vater)
            (text "Vater" 14 'black))
     
     (rectangle (/ size 10) 90 'solid 'white)
     (rectangle (/ size 10) 90 'solid 'black)
     (rectangle (/ size 10) 90 'solid 'white)
     
     ; Aufruf von Kindermachen & anzeigen der Viecher
     (Kindermachen Flügelfarbe_Mutter Flügelfarbe_Mutter_Rez Musterung_Mutter Musterung_Mutter_Rez
              Fühlerform_Mutter Fühlerform_Mutter_Rez Flügelform_Mutter Flügelform_Mutter_Rez
              Flügelfarbe_Vater Flügelfarbe_Vater_Rez Musterung_Vater Musterung_Vater_Rez
              Fühlerform_Vater Fühlerform_Vater_Rez Flügelform_Vater Flügelform_Vater_Rez Anzahl_Kinder 1)
     
     )))



;;; 1.4 Testdaten

; Die dominanten Gene überwiegen meistens.
; Selten, sofern Mutter & Vater zufällig passende rezessive
; Gene haben, die zufällig ausgewählt werden, kommen auch eigentlich nicht dominante Gene zum Vorschein.

; Durch die versteckten rezessiven von Vater/Mutter sind hier blau, rot und gelb möglich
; Blau ist hier am wahrscheinlichsten
(Paarung 'red 'blue 'dots 'star 'curved 'straight 'ellipse 'hexagon 6)

; Gelb und rot ist möglich, Gelb aber deutlich wahrscheinlicher
(Paarung 'yellow 'red 'star 'stripes 'curved 'curly 'ellipse 'rhomb 6)

; Hier entstehen nur rote (da rot die niedrigste Präzedenz hat, kann nichts niedrigeres rezessiv vorhanden sein)
(Paarung 'red 'red 'stripes 'dots 'curved 'straight 'ellipse 'rhomb 6)

