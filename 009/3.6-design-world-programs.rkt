;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 3.6-design-world-programs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 200)

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 2))
(define CAR-BODY-LENGTH (* WHEEL-RADIUS 8))

(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle WHEEL-DISTANCE WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define CAR-BODY (rectangle CAR-BODY-LENGTH WHEEL-DISTANCE "solid" "red"))
(define CAR-BODY-TOP (rectangle (/ CAR-BODY-LENGTH 2) WHEEL-RADIUS "solid" "red")) 

(define CAR (overlay/align/offset
             "middle" "top"
             BOTH-WHEELS
             0 -10
             (above/align "middle"
                         CAR-BODY-TOP
                         CAR-BODY)))

CAR