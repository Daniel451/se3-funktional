#lang racket

; Aufgabe 1

;; Aufgabe 1.1

(define (deg2rad deg)
  (* deg (/ pi 180))
  )

(define (rad2deg rad)
  (* rad (/ 180 pi))
  )