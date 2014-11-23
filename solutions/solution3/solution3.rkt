#lang racket

(require flaggen-module)

; Blatt 3 - Gebel Schulte Speck


; Aufgabe 1

; Aufgabe 1.1

;; Wir haben eine Liste von pairs gewählt, da sich dadurch zwei verknüpfte Werte
;; einfach zuordnen und abrufen lassen (car/cdr/usw..).

(define buchstabiertafel
  '(
    (#\A Alfa)
    (#\B Bravo)
    (#\C Charlie)
    (#\D Delta)
    (#\E Echo)
    (#\F Foxtrott)
    (#\G Golf)
    (#\H Hotel)
    (#\I India)
    (#\J Juliett)
    (#\K Kilo)
    (#\L Lima)
    (#\M Mike)
    (#\N November)
    (#\O Oskar)
    (#\P Papa)
    (#\Q Quebec)
    (#\R Romeo)
    (#\S Sierra)
    (#\T Tango)
    (#\U Uniform)
    (#\V Viktor)
    (#\W Wiskey)
    (#\X X-ray)
    (#\Y Yankee)
    (#\Z Zulu)
    (#\0 Nadazero)
    (#\1 Unaone)
    (#\2 Bissotwo)
    (#\3 Terrathree)
    (#\4 Kartefour)
    (#\5 Pantafive)
    (#\6 Soxisix)
    (#\7 Setteseven)
    (#\8 Oktoeight)
    (#\9 Novenie)
    (#\, Decimal)
    (#\. Stop)))


; Aufgabe 1.2
;; gibt ein Tupel der buchstabiertafel zurück, reversed dieses Tupel,
;; gibt den reverse-value zurück, sofern 'char im Tupel vorhanden ist
;; damit erhält man den Schlüssel zum passenden char

(define (char->key char)
  (car
   (reverse
    (assoc char buchstabiertafel)
    )
   )
  )

; Aufgabe 1.3
;; Konvertiert Kleinbuchstaben in Großbuchstaben
(define (charanycase->key char)
  (char->key (char-upcase char))
  )

; Aufgabe 1.4
;; 
(define (buchstabiere text)
  (letrec ((liste(lambda (satzliste ausgabeListe)
      (if (not (empty? satzliste))
        (cons 
          (cdr (cons 
                 ausgabeListe
                 (charanycase->key (car satzliste))))
          (liste (cdr satzliste) ausgabeListe))
        ausgabeListe))))
    (liste (string->list text) '()))
  )






; Aufgabe 2


; Aufgabe 2.1

;; Wir haben eine Liste von pairs gewählt, da sich dadurch zwei verknüpfte Werte
;; einfach zuordnen und abrufen lassen (car/cdr/usw..).

(define flaggentafel
   '((#\A A)
     (#\B B)
     (#\C C) 
     (#\D D)
     (#\E E)
     (#\F F)
     (#\G G)
     (#\H H)
     (#\I I)
     (#\J J)
     (#\K K)
     (#\L L)
     (#\M M)
     (#\N N)
     (#\O O)
     (#\P P)
     (#\Q Q)
     (#\R R)
     (#\S S)
     (#\T T)
     (#\U U)
     (#\V V)
     (#\W W)
     (#\X X)
     (#\Y Y)
     (#\Z Z)
     (#\0 Z0)
     (#\1 Z1)
     (#\2 Z2)
     (#\3 Z3)
     (#\4 Z4)
     (#\5 Z5)
     (#\6 Z6)
     (#\7 Z7)
     (#\8 Z8)
     (#\9 Z9)
     )
  )


; Aufgabe 2.2

;; Wandelt einen character in eine Flagge um

(define (char->flag x)
  (eval (car
         (reverse
          (assoc x flaggentafel)
          )
         )
        )
  )


; Aufgabe 2.3

;; Iteriert rekursiv über Teillisten, bis x die leere
;; Liste ist, verkettet dabei jeweils mit cons, um eine
;; neue Liste zu erzeugen. Dabei wird der jeweilige character
;; aus x per char-flag in eine Flagge gewandelt.
;; Baut also einen String zu einer Liste von Flaggen um.

(define (flaggennachricht x) 
  (if (string? x) (flaggennachricht (string->list x))
      (if (empty? x) '() 
          (cons (char->flag 
                 (char-upcase (car x))
                 ) 
                (flaggennachricht (cdr x))
                )
          )
      )
  )