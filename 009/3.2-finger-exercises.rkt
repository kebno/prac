;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 3.2-finger-exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)

; String -> String
; Returns first character of a non-empty strings
; given: "hello", expect: "h"
; given: "you", expect: "y"
(define (string-first str) 
  (string-ith str 0))

; String -> String
; Returns the last character from non-empty strings
; given: "hello", expect: "o"
; given: "89765341", expect: "1"
(define (string-last str)
  (string-ith str (- (string-length str) 1)))

; Image -> Number
; computes number of pixels in an image
; given: (square 10 "solid" "purple"), expect: 100
; given: (regular-polygon 10 3 "outline" "purple"), expect: 90
(define (image-area img)
  (* (image-width img) (image-height img)))

; String -> String
; gives string without first letter
; given: "hello", expect: "ello"
(define (string-rest str)
  (substring str 1 (string-length str)))

; String -> String
; gives string without last character
; given: "hello", expect: "hell"
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))


; Number -> Number
; converts Fahrenheit temperatures to Celsius temperatures
; given 32, expected 0
; given 212, expected 100
; given -40, expected -40
(check-expect (f2c -40) -40)
(check-expect (f2c 32) 0)
(check-expect (f2c 212) 100)

(define (f2c f)
  (* 5/9 (- f 32)))

