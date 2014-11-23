#lang racket
; Blatt 4 - Gebel, Schulte, Speck

; Aufgabe 1: Auswertung von Ausdrücken
(displayln "Aufgabe 1")
; Zu welchen Werten evaluieren die folgenden Racket-Ausdrücke? 
; 1.1.
   (displayln "1.1.")
   (max (min 2 (- 2 5)) 0)
   (displayln "")
; Begründung:
; Dieser Ausdruck evaluiert zu 0. Zuerst wird (- 2 5) zu -3 ausgewertet.  
; Das Minimum von 2 und -3 ist -3; Zum Schluss wird das Maximum von -3 und 0 ausgewertet,
; welches 0 ist. 

; 1.2.
   (displayln "1.2.")
   '(+ (- 2 13) 11)
   (displayln "")
; Begründung:
; Dieser Ausdruck evaluiert zu '(+ (- 2 13) 11), da das Apostroph dafür sorgt, dass der 
; Ausdruck als Liste interpretiert wird. Da hierbei keine Operation darauf angewendet wird,
; wird die gesamte Liste zurückgegeben. 

; 1.3.
   (displayln "1.3.")
   (cadr '(Alle Jahre wieder))
   (displayln "")
; Begründung:
; Dieser Ausdruck evaluiert zu 'Jahre. Der Akzessor cadr ist mit (car(cdr Liste)) gleichgesetzt.
; Zuerst wird also (cdr (Liste)) ausgewertet, wodurch wir '(Jahre wieder) erhalten. Im Nachhinein
; wird (car (Liste)) ausgewertet, welches zu 'Jahre führt. 

; 1.4.
   (displayln "1.4.")
   (cddr '(kommt (das Weihnachtsfesr)))
   (displayln "")
; Begründung:
; Dieser Audruck evaluiert zu '(). Der Akzessor cddr ist mit (cdr(cdr Liste)) gleichgesetzt, d.h.  
; der Akzessor gibt die Liste ab dem dritten Element zurück. Da die Liste lediglich zwei Elemente
; enthält, wird die leere Liste zurückgegeben. 

; 1.5.
   (displayln "1.5.")
   (cdadr '(kommt (das . Weihnachtsfest)))
   (displayln "")
; Begründung:
; Dieser Ausdruck evaluiert zu 'Weihnachtsfest. Der Akzessor ist mit (cdr(car(cdr Liste) gleichgesetzt.
; Mit dem inneren cdr wird zuerst '(das . Weihnachtsfest) zurückgegeben. Dann liefert car 'das. 
; Zum Schluss werden mit cdr die Elemente ab dem zweiten Element der Liste zurückgegeben. Hierbei
; handelt es sich jedoch nur um das Element 'Weihnachtsfest, das schlussendlich zurückgegeben wird. 

; 1.6.
   (displayln "1.6.")
   (cons 'Listen '(ganz einfach und))
   (displayln "")
; Begründung:
; Dieser Ausdruck evaluiert zu '(Listen ganz einfach und). Hierbei dient die Funktion cons zur 
; Konstruktion eines Paares. Aufgrund des "syntaktischen Zuckers" wird das Paar hierbei als eine
; Liste dargestellt. (Paare, deren zweites Element eine Liste ist, werden in der vereinfachten 
; Listennotation dargestellt).

; 1.7.
   (displayln "1.7.")
   (cons 'Paare 'auch)
   (displayln "")
; Begründung:
; Dieser Audruck evaluiert zu '(Paare . auch). Hierbei konstruiert die Funktion cons aus zwei Symbolen
; ein Paar. Da es sich hierbei lediglich um zwei Symbole handelt, zeigt Racket sie im Nachhinein in der
; Paarnotation (d.h. inkl. dot-Operator an). 

; 1.8.
   (displayln "1.8.")
   (equal? (list 'Racket 'Prolog 'Java) '(Racket Prolog Java))
   (displayln "")
; Begründung:
; Dieser Ausdruck liefert true. Die Funktion equal? prüft auf Gleichheit. Da "list" und " ' " die 
; gleiche Funktion haben, nämlich eine Liste mit Elementen zu füllen, evaluiert der Ausdruck zu true. 
; Grund dafür ist, dass der Inhalt beider Listen gleich ist. 

; 1.9.
   (displayln "1.9.")
   (eq? (list 'Racket 'Prolog 'Java) (cons 'Racket '(Prolog Java)))
   (displayln "")
; Begründung:
; Dieser Ausdruck liefert false. Die Funktion eq? testet auf Identität. Obwohl beide Listen nach Anwendung  
; der Funktion cons inhaltlich gleich sind, sind sie nicht identisch. 


; Aufgabe 2: Textgenerierung
(displayln "Aufgabe 2")
; 2.1.: Die Grammatik (Backus-Naur-Form)

; <Notmeldung>                  ::= <Überschrift> <Standortangabe> <Notfallart> <ErforderlicheHilfeleistung>  
;                                   <ZweiPeilzeichen> <Unterschrift> "Over"
; <Überschrift>                 ::= <DreiNotzeichen> <EigeneMeldung> <DreiMalSchiffsname> <RufzeichenBuchstabiert> 
;                                   <Notzeichen> <Schiffsname> <SchiffsnameBuchstabiert>
; <DreiNotzeichen>              ::= <Notzeichen> <Notzeichen> <Notzeichen>
; <Notzeichen>                  ::= "MAYDAY"
; <EigeneMeldung>               ::= "HIER IST" | "DELTA ECHO"
; <DreiMalSchiffsname>          ::= <Schiffsname> <Schiffsname> <Schiffsname>
; <Schiffsname>                 ::= String
; <RufzeichenBuchstabiert>      ::= <key> <key> <key> <key> 
; <key>                         ::= <"Alfa">    | <"Bravo">      | <"Charlie">   | <"Delta">    | <"Echo">     | <"Foxtrott">   | <"Golf">      | <"Hotel">     | 
;                                   <"India">   | <"Juliette">   | <"Kilo">      | <"Lima">     | <"Mike">     | <"November">   | <"Oscar">     | <"Papa">      | 
;                                   <"Quebec">  | <"Romeo">      | <"Sierra">    | <"Tango">    | <"Uniform">  | <"Viktor">     | <"Whiskey">   | <"X-Ray">     | 
;                                   <"Yankee">  | <"Zulu">       | <"Nadazero">  | <"Unaone">   | <"Bissotwo"> | <"Terrathree"> | <"Kartefour"> | <"Pantafive"> | 
;                                   <"Soxisix"> | <"Setteseven"> | <"Oktoeight"> | <"Novenine"> | <"Decimal">  | "Stop" 
; <SchiffsnameBuchstabiert>     ::= <key> | <key> <SchiffsnameBuchstabiert>
; <Standortangabe>              ::= String
; <Notfallart>                  ::= String
; <ErforderlicheHilfeleitung>   ::= String
; <ZweiPeilzeichen>             ::= "ICH SENDE DEN TRÄGER" <Peilzeichen> <Peilzeichen>
; <Peilzeichen>                 ::= "-"
; <Unterschrift>                ::= <Schiffsname> <RufzeichenBuchstabiert>
 

; 2.2.: Der Generator
  (displayln "2.2.")



  (displayln "")

; 2.3.: Der Test
  (displayln "2.3.")



  (displayln "")

; Aufgabe 3: Funktionen vs. Spezialformen
(displayln "Aufgabe 3")

; Innere Reduktion:
; Bei der inneren Reduktion werden die Terme eines Ausdrucks von innen nach außen ausgewertet. 

; Äußere Reduktion:
; Bei der äußeren Reduktion werden die Terme eines Ausdrucks von außen nach innen ausgewertet. 

(displayln "Auswertung des des Ausdrucks: (hoch3 (* 3 (+ 1 (hoch3 2)))) mit (define (hoch3 x) (* x x x)")

(define (hoch3 x)
  (* x x x))

(displayln"")
(displayln "... mit innerer Reduktion:")
'(hoch3 (* 3 (+ 1 (hoch3 2))))
'(hoch3 (* 3 (+ 1 (* 2 2 2))))
'(hoch3 (* 3 (+ 1 8)))
'(hoch3 (* 3 9))
'(hoch3 27)
'27*27*27
(display "= ") (hoch3 (* 3 (+ 1 (hoch3 2))))
        
(displayln "")

(displayln "... mit äußerer Reduktion:")
'(hoch3 (* 3 (+ 1 (hoch3 2))))
'(* (* 3 (+ 1 (hoch3 2))) (* 3 (+ 1 (hoch3 2))) (* 3 (+ 1 (hoch3 2))) )
'(* (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (hoch3 2))) (* 3 (+ 1 (hoch3 2))) )
'(* (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (hoch3 2))) )
'(* (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))) )
'(* (* 3 (+ 1 8)) (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))) )
'(* (* 3 9) (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))) )
'(* 27 (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))) )
'(* 27 (* 3 (+ 1 8)) (* 3 (+ 1 (* 2 2 2))) )
'(* 27 (* 3 9) (* 3 (+ 1 (* 2 2 2))) )
'(* 27 27 (* 3 (+ 1 (* 2 2 2))) )
'(* 27 27 (* 3 (+ 1 8)) )
'(* 27 27 (* 3 9) )
'(* 27 27 27 )
(display "= ") (hoch3 (* 3 (+ 1 (hoch3 2))))


; Welche Reduktionsstrategie wird in Racket für Funktionen angewendet und welche für
; Spezialformen (special form expressions)?

; Funktionen:     innere Reduktion
; Spezialformen:  äußere Reduktion

; Redefinition von if als normale Funktion, anstatt Spezialform:
; Bei dem redefiniertem if als new-if Funktion führt die rekursive Berechnung der Fakultät
; wahrscheinlich zu einem Überlauf des Speichers. Da bei Funktionen die innere Reduktions-
; strategie angewendet wird, versucht die new-if Funktion den innersten Aufruf (faculty 115) 
; als erstes auszuwerten. Aufgrund der Rekursion geht der Aufruf beliebig weit in die Tiefe, 
; sodass der Aufrufbaum unendlich groß wird und es zu einem Fehler kommt. 