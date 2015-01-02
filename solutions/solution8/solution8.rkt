#lang racket
(require 2htdp/image)

; Blatt 8 - Gebel, Schulte, Speck





; Aufgabe 1


;; 1.1 - Wann ist eine Racket-Funktion eine Funktion höherer Ordnung?
;;; Eine Racket-Funktion ist eine Funktion höherer Ordnung, wenn besagte Funktion
;;; als Argumente nicht nur Werte, sondern wiederrum Funktionen erhält.


;; 1.2
;;; (a): foldl ist eine Funktion höherer Ordnung.
;;; foldl ist standardmäßig in racket implementiert,
;;; die Funktion übernimmt eine zweite Funktion sowie einen Initialwert und eine Liste
;;; und wendet dann diese zweite Funktion paarweise auf alle Elemente der Liste an. Das erste
;;; Wertepaar bildet der Initalwert sowie das erste Listenelement, das letzte Paar besteht
;;; aus dem vorletzten und letzten Listenelement.
;;;
;;; (b): diese Funktion gibt nur eine Funktion zurück, bekommt aber einen normalen Wert übergeben,
;;; ist also keine Funktion höherer Ordnung
;;;
;;; (c): diese Funktion ist eine Funktion höherer Ordnung, da pimento eine Funktion f übergeben
;;; bekommt sowie ein Argument arg1, später führt die Funktion dann (f arg1 arg2) aus.
;;;
;;; (d): ist keine Funktion höherer Ordnung, berechnet lediglich eine Division aus Sinus x durch 
;;; Kosinus x, wobei x der übergebene Wert ist.


;; 1.3
;;; ((pimento * 5) 7)
;;;
;;; Zur Zeit des Aufrufs ((pimento * 5) 7) wird durch die innere Klammer die Funktion pimento
;;; aufgerufen, welche die Zwei Argumente f und arg1 besitzt. Hierbei wird die Funktion '*' an das
;;; Argument 'f' gebunden und der Wert '5' an das Argument arg1.
;;; Das zweite Argument 'arg2' ist pimento selbst nicht bekannt, es ist das Argument der Lambda-Funktion,
;;; welche erst in pimento aufgerufen wird. Dementsprechend wird '7', der verbleibende Wert in den
;;; äußeren Klammern beim Aufruf der Lambda-Funktion als Wert an das Lambda-Argument 'arg2' gebunden.
;;; Dadurch ergibt sich zur Laufzeit (* 5 7), was zu 35 evaluiert.


;; 1.4
;;; (foldl (curry * 2) 1 '(1 1 2 3))
;;; evaluiert zu: 96
;;; Begründung: foldl, wie oben beschrieben, führt die Funktion f (curry * 2) paarweise auf jedem
;;; Element der Liste 

;;; (map cons '(1 2 3 4) '(1 2 3 4))
;;; evaluiert zu: '((1 . 1) (2 . 2) (3 . 3) (4 . 4))

;;; (filter pair? '((a b) () 1 (())))
;;; evaluiert zu: '((a b) (()))

;;; (map (compose (curry + 33) (curry * 1.8)) '(5505 100 0 1 1000 -273.15))
;;; evaluiert zu: '(9942.0 213.0 33 34.8 1833.0 -458.66999999999996))





