#lang racket
(require 2htdp/image)

; Blatt 8 - Gebel, Schulte, Speck





; Aufgabe 1

(displayln "> Aufgabe 1")
(displayln "> siehe Quelltextkommentare")
(displayln "")
(displayln "")
(displayln "")

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
;;; Element der Liste aus.
;;; D.h. auf jedem Paar wird (curry * 2) aufgerufen,
;;; letztendlich ergibt sich also:
;;; (* 2 (* 2 (* 2 (* 2 1 1) 1) 2) 3)

;;; (map cons '(1 2 3 4) '(1 2 3 4))
;;; evaluiert zu: '((1 . 1) (2 . 2) (3 . 3) (4 . 4))
;;; Begründung: map wendet die Funktion f (cons) auf jedem Element der übergebenen Liste an,
;;; in diesem Fall, da zwei Listen übergeben wurden, simultan auf jeweils einem Wertepaar.
;;; Da die Funktion f in diesem Fall cons ist, wird aus jedem Wertepaar sukzessive durch cons
;;; ein Paar erstellt. So wird aus 1 und 1 im ersten Aufruf durch durch (cons 1 1) das Paar (1 . 1).

;;; (filter pair? '((a b) () 1 (())))
;;; evaluiert zu: '((a b) (()))
;;; Begründung: filter filtert aus der gegebenen Liste alle Elemete, die das Prädikat pair?
;;; erfüllen und gibt die Restliste wieder zurück. 1 und () sind kein Paar, deshalb werden sie gefiltert.

;;; (map (compose (curry + 33) (curry * 1.8)) '(5505 100 0 1 1000 -273.15))
;;; evaluiert zu: '(9942.0 213.0 33 34.8 1833.0 -458.66999999999996))
;;; Begründung: compose verknüpft die Funktionen (curry + 33) und (curry * 1.8), d.h. sie werden
;;; nacheinander ausgeführt auf die übergebenen Elemente.
;;; Erst wird durch map jedes element der Liste geholt und dann mit 1.8 multipliziert
;;; und zu dem Ergebnis 33 addiert.
;;; Zum Schluss gibt map dann die neue Liste zurück.




; Aufgabe 2

(displayln "> Aufgabe 2")
(displayln "> siehe Quelltextkommentare & Ausgabe")
(displayln "")

;; 2.1
(define (absolute xs)
    (map abs (filter number? xs))
 )

(displayln "> Aufgabe 2.1")
(displayln "> Ausdruck: (map abs (filter number? '(1 2 -5 'lollipop' -10)))")
(absolute '(1 2 -5 "lollipop" -10))
(displayln "")

;; 2.2
(define (teilbar xs)
 (filter (lambda (i) (integer? (/ i 3))) xs)
)

(displayln "> Aufgabe 2.2")
(displayln "> Ausdruck: (filter (lambda (i) (integer? (/ i 3))) '(3 6 9 10 11 20 30 40))")
(teilbar '(3 6 9 10 11 20 30 40))
(displayln "")

;; 2.3
(define (komplexeSumme xs)
 (foldl + 0 (filter (lambda (i) (and (> i 10) (even? i))) xs))
 )

(displayln "> Aufgabe 2.3")
(displayln "> Ausdruck: (foldl + 0 (filter (lambda (i) (and (> i 10) (even? i))) '(1 2 3 4 10 20 30 50 55 65 5)))")
(komplexeSumme '(1 2 3 4 10 20 30 50 55 65 5))
(displayln "")
;;; 20 + 30 + 50 = 100

;; 2.4
(define (part f xs)
 (partition f xs)
 )

(displayln "> Aufgabe 2.4")
(displayln "> Ausdruck: (partition odd? '(1 2 3 4 5 6))")
(part odd? '(1 2 3 4 5 6))

(displayln "")
(displayln "")
(displayln "")




; Aufgabe 3: Das Kartenspiel SET!

(displayln "> Aufgabe 3")

;; 3.1 - Repräsentation der verfügbaren Ausprägungen einer Spielkarte

;;; Eigenschaften
;;; Form   : | Oval  | Rechteck  | Welle
;;; Farbe  : | rot   | blau      | grün
;;; Anahl  : | ein   | zwei      | drei
;;; Füllung: | Linie | Schraffur | Fläche


(require "setkarten-module.rkt")
    
;;; Übersetzt eine Zahl n in die dazugehörige Form
(define (number2pattern n)
    (case n
    [(1) 'waves]
    [(2) 'oval]
    [(3) 'rectangle]
    [else (error "Zahl für Form ungültig.")]
    )
)

;;; Übersetzt eine Zahl n in die dazugehörige Fuellung
(define (number2mode n)
    (case n
    [(1) 'outline]
    [(2) 'solid]
    [(3) 'hatched]
    [else (error "Zahl für Füllung ungültig.")]
    )
)

;;; Übersetzt eine Zahl n in die dazugehörige Farbe
(define (number2color n)
    (case n
    [(1) 'red]
    [(2) 'green]
    [(3) 'blue]
    [else (error "Zahl für Farbe ungültig.")]
    )
)

;;; Hilfsfunktion: Nimmt ein 4er-Tupel in Form einer Liste und erhöht die Einträge von links nach rechts.
;;; Jede Stelle der Liste wird maximal bis 3 erhöht.
;;; Aus '(1 1 1 1) wird z.B. '(2 1 1 1)
;;; '(3 1 1 1) -> '(1 2 1 1)
;;; usw...

;;; Benötigt also eine Liste und gibt eine Liste zurück
(define (incList xs)
    (let* (
           [a (add1 (car xs))]
           [b (cdr xs)]
           )
        (if (equal? a 4)
            (if (equal? b '())
                '()
                (cons 1 (incList b))
            )
            (cons a b)
        )
    )
)


;; 3.2 - Kartenstapelgenerierung

;;; Hilfsfunktion, welche die kompletten 81 Permutationen von 1, 2 und 3 auf vier Plätzen in 
;;; einer Liste berechnet, wenn als Startpermutation (1 1 1 1) übergeben wird.
;;; Benötigt eine Liste curPermutation
;;; Gibt eine Liste aller Permutationen zurück

(define (listGenerator curPermutation)
    (case curPermutation 
        ['(3 3 3 3)  (list '(3 3 3 3))]
        [else (cons curPermutation (listGenerator (incList curPermutation)))]
    )
)

;;; Übersetzungsfunktion, die aus einem 4er-Tupel mit Zahlen ein 4er-Tupel mit den Eigenschaften
;;; macht, die von "setkarten-module" gelesen werden können, um die Karten grafisch
;;; darzustellen.
;;; Benötigt eine Liste xs (4er-Tupel aus Zahlen von 1 bis 3)
;;; Gibt eine Liste der Eigenschaften zurück

(define (nlist2elist xs)   
    (list
        (car xs) 
        (number2pattern (cadr xs)) 
        (number2mode (caddr xs)) 
        (number2color (cadddr xs))
    )
)

;;; Hilfsfunktion, die den Kartenstapel generiert (Jede Karte wird bereits durch
;;; ihre Eigenschaften dargestellt)

(define (kartenstapel)   
    (map nlist2elist (listGenerator '(1 1 1 1)))
)

;;; Wendet die Darstellungsfunktion für eine Karte auf alle 81 Karten des Kartenstapels an.
;;; Zurückgegeben werden alle Karten des Kartenstapels als Bild.
(define (showKartenstapel)
    (map (lambda (xs) (apply show-set-card xs)) (kartenstapel))
)


;; 3.3 - Kartenvergleich

;;; Eine Hilfsfunktion die entscheidet, ob drei Objekte a, b und c 3x dieselbe Ausprägung
;;; einer Eigenschaft oder komplett unterschiedliche Ausprägungen haben.

;;; Das ist wichtig, da ein Set aus drei Karten besteht, die für jede Eigenschaft die
;;; Bedingung erfüllen müssen, dass alle Karten in dieser Eigenschaft übereinstimmen oder
;;; das keine zwei der Karten in dieser Eigenschaft übereinstimmen.

;;; Benötigt drei Integer a, b, c, die jeweils eine Ausprägung einer Eigenschaft symbolisieren.
;;; Gibt einen booleschen Wert zurück, ob die übergebene Kombination ein gültiges Set ist.

(define (set? a b c)
    (or 
        (and
            (not (equal? a b))
            (not (equal? a c))
            (not (equal? b c))
        )
        (and
            (equal? a b)
            (equal? b c)
        )
    )
)


;;; Überprüft, ob drei übergebene Karten ein gültiges Set sind.

(define (is-a-set? karte1 karte2 karte3)
    (andmap set? karte1 karte2 karte3)
)






