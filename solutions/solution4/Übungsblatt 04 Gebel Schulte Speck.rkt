#lang racket

;1 (will Britta vortragen)
(displayln "--- Aufgabe 1 ---")

;1.1
(max (min 2 (- 2 5)) 0)
;Das Minimum von 2 und 2-5=-3 ist 3, das Maximum von -3 und 0 ist 0.

;1.2
'(+ (- 2 13) 11)
;"'" definiert den Ausdruck als Symbol, also wird er so ausgegeben.

;1.3
(cadr '(Alle Jahre wieder))
;Gibt (car (cdr '(Alle Jahre wieder))) zurück. 
;(cdr '(Alle Jahre wieder)) -> '(Jahre wieder)
;(car '(Jahre wieder)) -> Jahre.

;1.4
(cddr '(kommt (das Weihnachtfest)))
;Die Elemente der Liste sind "kommt" und "(das Weihnachtsfest)", also ist das 3. Element leer.

;1.5
(cdadr '(kommt (das . Weihnachtfest)))
;Gibt (cdr (car (cdr '(kommt (das . Weihnachtfest))))) zurück.
;(cdr '(kommt (das . Weihnachtfest))) -> '((das . Weihnachtfest)) Liste die ein Paar enthält
;(car '((das . Weihnachtfest)) -> (das . Weihnachtfest) Paar
;(cdr (das . Weihnachtfest)) -> Weihnachtsfest 

;1.6
(cons 'Listen '(ganz einfach und))
;Wegen der Reihenfolge der Argumente (2. Argument ist selbst durch cons produzieert) evaluiert der Ausdruck zu einer Liste.
;(cons '(ganz einfach und) 'Listen) würde zu einem Paar führen.

;1.7
(cons 'Paare 'auch)
;Hier produziert cons ein Paar, da beide Argumente keine Listen sind.
;(cons 'Paare '(auch)) würde wieder zu einer Liste evaluieren.

;1.8
(equal? (list 'Racket 'Prolog 'Java) '(Racket Prolog Java))
;Für Paare gibt es genauere Spezifikationen bei equal?, es wird nicht geprüft ob das Objekt das selbe ist, sondern ob der Inhalt gleich ist.
;Dies trifft hier zu, deswegen liefert equal? true.

;1.9
(eq? (list 'Racket 'Prolog 'Java) (cons 'Racket '(Prolog Java)))
;(list 'Racket 'Prolog 'Java) und (cons 'Racket '(Prolog Java))) beziehen sich nicht auf das selbe Objekt, deswegen liefert eq? false.

