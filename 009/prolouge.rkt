;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname prolouge) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)


(define WIDTH  200)
(define HEIGHT 400)
(define GROUND-HEIGHT 10)
(define MTSCN (place-image
               (rectangle WIDTH GROUND-HEIGHT "solid" "gray")
               (/ WIDTH 2) HEIGHT
               (empty-scene WIDTH HEIGHT "blue")))
(define ROCKET (overlay (circle 10 "solid" "green")
         (rectangle 40 4 "solid" "green")))
(define ROCKET-CENTER-TO-BOTTOM
  (/ (image-height ROCKET) 2))
(define GROUND-Y
  (- HEIGHT (+ ROCKET-CENTER-TO-BOTTOM GROUND-HEIGHT)))

; functions
(define (create-rocket-scene.v5 h)
  (cond
    [(<= h GROUND-Y)
     (place-image ROCKET (/ WIDTH 2) h MTSCN)]
    [(> h GROUND-Y)
     (place-image ROCKET (/ WIDTH 2) GROUND-Y MTSCN)]))

GROUND-Y
(animate create-rocket-scene.v5)