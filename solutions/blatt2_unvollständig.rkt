#lang racket

; Alexander Gebel, Britta Schulte, Daniel Speck

; Aufgabe 1: Symbole und Werte, Umgebungen
(define miau 'Plueschi)
(define katze miau)
(define tiger 'miau)

(define (welcherNameGiltWo PersonA PersonB)
  (let ((PersonA 'Sam)
        (PersonC PersonA))
    PersonC))

(define xs1 '(0 2 3 katze))
(define xs2 (list miau katze))
(define xs3 (cons katze miau))

(displayln "----- Aufgabe 1 -----") 
; Zu welchen Werten evaluieren die folgenden Ausdrücke? Begründen Sie die Antwort.


(displayln "1.1.") miau 
; "miau" evaluiert zu Symbol "Plueschi". Die weitere Evaluierung wird durch "'" 
; blockiert und die Argumente des Symbols werden wörtlich zurückgegben. 

(displayln "1.2.") katze 
; "katze" evaluiert zu "miau", welches wiederum zum Symbol "Plueschi" evaluiert.
; Da vor "Plueschi" das Quotierungszeichen "'" steht, wird die weitere Evaluierung 
; blockiert und die Argumente des Symbols werden wörtlich zurückgegben.

(displayln "1.3.") tiger 
; "tiger" evaluiert zum Symbol "miau". Die weitere Evaluierung wird durch "'" blockiert 
; und die Argumente des Symbols werden wörtlich zurückgegben. 

(displayln "1.4.") (quote katze) 
; Die Funktion "quote" ist die Langfassung des Quotierungszeichens "'". Hierbei wird "katze" 
; quotiert, woraufhin die weitere Evaluierung geblockt wird und die Argumente wörtlich
; zurückgegben werden. 

;(displayln "1.5.") (eval tiger) 
; "tiger" wird von der Funtkion "eval" zum Symbol "'miau" evaluiert. Im Nachhinein versucht
; die Funktion "eval" das Symbol "'miau" zu evaluieren, d.h. es als Code darzustellen. Da es nicht definiert ist, 
; kommt es zu der Fehlermeldung "miau: unbound identifier". (Aus diesem Grund wurde der Ausdruck auskommentiert).

;(displayln "1.6.") (eval katze) 
; "katze" evaluiert zu "miau", weleches wiederum zum Symbol "'Plueschi" evaluiert.
; Im Nachhinein versucht die Funktion "eval" das Symbol "'Plueschi" zu evaluieren, d.h. es als Code darzustellen. 
; Da es nicht definiert ist, kommt es zu der Fehlermeldung "Plueschi: unbound identifier". 
; (Aus diesem Grund wurde der Ausdruck auskommentiert).

;(displayln "1.7.") (eval 'tiger) 
; Die Funktion "eval" versucht das Symbol "'tiger" zu evaluieren, d.h. es als Code darzustellen. Da es nicht definiert ist, 
; kommt es zu der Fehlermeldung "tiger: unbound identifier". (Aus diesem Grund wurde der Ausdruck auskommentiert).

(displayln "1.8.") (welcherNameGiltWo 'harry 'potter) 
; ???????????

(displayln "1.9.") (cdddr xs1) 
; Der Akzessor "(cdddr xs1)" ist das Äquivalent zu "(cdr(cdr(cdr xs1)))". Er liefert das Element an der dritten Stelle des Körpers. 
; Anmerkung: Gäbe es hinter Katze weitere Elemente in der Liste, würden sie durch den Akzessor "(cdddr xs1)" ab "'(katze)"
; auch angezeigt werden.

(displayln "1.10.") (cdr xs2) 
; Der Akzessor "(cdr xs2)" liefert das Element an der ersten Stelle des Körpers. In diesem Fall handelt es sich um "miau".
; Da "miau" vorher defniert wurde, evaluiert es zum Symbol "'Plueschi". Die weitre Evaluation wird durch "'" geblockt, 
; sodass die Argumente des Symbols wörtlich zurückgegeben werden. 

(displayln "1.11.") (cdr xs3) 
; Der Akzessor "(cdr xs3)" liefert das Element an der ersten Stelle des Körpers. In diesem Fall handelt es sich um "katze".
; "katze" evaluiert zu "miau", welches wiederum zum Symbol "'Plueschi" evaluiert. Die weitre Evaluation wird durch "'" 
; geblockt, sodass die Argumente des Symbols wörtlich zurückgegeben werden.

;(displayln "1.12.") (eval (sqrt 3))
; ?????????

;(displayln "1.13.") (eval '(welcherNameGiltWo 'tiger 'katze))
; Die Funtkion "eval" versucht das Symbol "'(welcherNameGiltWo...)" auszuwerten und scheitert daran. Da dieses Symbol nicht 
; definiert ist, kommt es zu der Fehlermeldung "welcherNameGiltWo: unbound identifier". (Aus diesem Grund wurde der Ausdruck auskommentiert).

;(displayln "1.14.") (eval (welcherNameGiltWo 'katze 'tiger))
; Die Funktion "eval" wertet zuerst "(welcherNameGiltWo)" aus, danach versucht sie das Symbol "'katze" auszuwerten. 
; Da dieses Symbol nicht definiert ist, kommt es zu der Fehlermeldung "katze: unbound identifier". 
;(Aus diesem Grund wurde der Ausdruck auskommentiert).

;-------------------------------------------------------------------------------------------------------------------------------

; Aufgabe 2: Rechnen mit exakten Zahlen

; Aufgabe 2.1.: Die Fakultät einer Zahl
(define (fak n)
  (if (= n 0)
      1
      (* n (fak (- n 1)))))

; Aufgabe 2.2.: Potenzen von Rationalzahlen
(define (power r n)
  (if (= n 0)
      1
      (if (even? n)
          (sqr (power r (/ n 2)))        ; Bei geradem n wird diese Funktion ausgeführt.
          (* (power r (- n 1)) r))))     ; Bei ungeradem n wird diese Funktion ausgeführt.

; Aufgabe 2.3.: Die Eulerzahl e
(displayln "----- Aufgabe 2.3 -----")

(define (eulerzahl)
   (*
    (/ 
    (let hilfsfunktion ([i 0])
       (if (< (/ 1 (expt 10 1000)) (/ (+ i 1) (fak i)))
           (+ (/ (+ i 1) (fak i)) (hilfsfunktion (+ i 1)))
           0
        ))
    2)
   (expt 10 1001))
  ) 

(eulerzahl)


; Aufgabe 2.4.: Die Zahl pi
; ????

;-------------------------------------------------------------------------------------------------------------------------------

; Aufgabe 3: Typprädikate
(define (type-of x)
  (cond
    [(boolean? x) "Boolean"]
    [(pair? x) "Pair"]
    [(list? x) "List"]
    [(symbol? x) "Symbol"]
    [(number? x) "Number"]
    [(char? x) "Char"]
    [(string? x) "String"]
    [(vector? x) "Vector"]
    [(procedure? x) "Procedure"]
    [else "Nicht bekannt"]))

(displayln "\n")
(displayln "----- Aufgabe 3 -----") 
    
(displayln "3.1.") (type-of (* 2 3 4))
; Der Ausdruck liefert das Typprädikat "Number", da die Funktion eine Multiplikation mit drei Zahlen durchführt. 

(displayln "3.2.") (type-of (not 42))
; Der Ausdruck liefert das Typprädikat "Boolean", da mit "not" der boolesche Wert negiert wird und somit ein 
; Wahrheitswert zustande kommt.

(displayln "3.3.") (type-of '(eins zwei drei))
; Der Ausdruck liefert das Typprädikat "Pair", 

(displayln "3.4.") (type-of '())
; Der Ausdruck liefert das Typprädikat "List". Jedoch hat diese Liste weder Kopf noch Körper, d.h. sie ist leer. 

(displayln "3.5.") (define (id z) z)
; ????
(displayln "")

(displayln "3.6.") (type-of (id sin))
; ????

(displayln "3.7.") (type-of (string-ref "Harry_Potter_und_der_Stein_der_Weisen" 3))
; Der Ausdruck liefert das Typprädikat "Char". Wahrscheinlich wird mit dieser Funktion das dritte Zeichen des Strings ausgegeben.

(displayln "3.8.") (type-of (lambda (x) x))
; ????
 
