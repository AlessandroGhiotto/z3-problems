;find the right moves to solve the peg game:
;https://www.wikihow.com/Win-the-Peg-Game


(declare-const A0 (Array Int Bool))
(declare-const x0 Int)
(declare-const y0 Int)
(declare-const z0 Int)
(declare-const A1 (Array Int Bool))
(declare-const x1 Int)
(declare-const y1 Int)
(declare-const z1 Int)
(declare-const A2 (Array Int Bool))
(declare-const x2 Int)
(declare-const y2 Int)
(declare-const z2 Int)
(declare-const A3 (Array Int Bool))
(declare-const x3 Int)
(declare-const y3 Int)
(declare-const z3 Int)
(declare-const A4 (Array Int Bool))
(declare-const x4 Int)
(declare-const y4 Int)
(declare-const z4 Int)
(declare-const A5 (Array Int Bool))
(declare-const x5 Int)
(declare-const y5 Int)
(declare-const z5 Int)
(declare-const A6 (Array Int Bool))
(declare-const x6 Int)
(declare-const y6 Int)
(declare-const z6 Int)
(declare-const A7 (Array Int Bool))
(declare-const x7 Int)
(declare-const y7 Int)
(declare-const z7 Int)
(declare-const A8 (Array Int Bool))
(declare-const x8 Int)
(declare-const y8 Int)
(declare-const z8 Int)
(declare-const A9 (Array Int Bool))
(declare-const x9 Int)
(declare-const y9 Int)
(declare-const z9 Int)
(declare-const A10 (Array Int Bool))
(declare-const x10 Int)
(declare-const y10 Int)
(declare-const z10 Int)
(declare-const A11 (Array Int Bool))
(declare-const x11 Int)
(declare-const y11 Int)
(declare-const z11 Int)
(declare-const A12 (Array Int Bool))
(declare-const x12 Int)
(declare-const y12 Int)
(declare-const z12 Int)
(declare-const A13 (Array Int Bool))
(declare-const x13 Int)
(declare-const y13 Int)
(declare-const z13 Int)


;START
(define-fun START ( (A (Array Int Bool)) ) Bool
	(and
		(not (select A 1)) (select A 2) (select A 3) (select A 4) (select A 5) 
		(select A 6) (select A 7) (select A 8) (select A 9) (select A 10) 
		(select A 11) (select A 12) (select A 13) (select A 14) (select A 15) 
	)
)

;END
;~(or a b ...) = (and ~a ~b...)
(define-fun END ( (A (Array Int Bool)) ) Bool
	(not
		(or
			(select A 1) (select A 2) (select A 3) (select A 4) (select A 5) 
			(select A 6) (select A 7) (select A 8) (select A 9) (select A 10) 
			(select A 11) (select A 12) (not (select A 13)) (select A 14) (select A 15) 
		)
	)
)

;           1
;         2   3
;       4   5   6 
;     7   8   9   10
;   11  12  13  14   15


;all possible set of cases (truples)
(define-fun TRUPLE ( (x Int) (y Int) (z Int) ) Bool
	(or
		(and (= x 1) (= y 2) (= z 4)) (and (= x 1) (= y 3) (= z 6)) (and (= x 2) (= y 4) (= z 7)) (and (= x 2) (= y 5) (= z 9)) (and (= x 3) (= y 5) (= z 8))
		(and (= x 3) (= y 6) (= z 10)) (and (= x 4) (= y 7) (= z 11)) (and (= x 4) (= y 8) (= z 13)) (and (= x 4) (= y 5) (= z 6)) (and (= x 5) (= y 8) (= z 12))
		(and (= x 5) (= y 9) (= z 14)) (and (= x 6) (= y 9) (= z 13)) (and (= x 6) (= y 10) (= z 15)) (and (= x 7) (= y 8) (= z 9)) (and (= x 8) (= y 9) (= z 10))
		(and (= x 11) (= y 12) (= z 13)) (and (= x 12) (= y 13) (= z 14)) (and (= x 13) (= y 14) (= z 15)) 
		
		(and (= x 4) (= y 2) (= z 1)) (and (= x 6) (= y 3) (= z 1)) (and (= x 7) (= y 4) (= z 2)) (and (= x 9) (= y 5) (= z 2)) (and (= x 8) (= y 5) (= z 3))
		(and (= x 10) (= y 6) (= z 3)) (and (= x 11) (= y 7) (= z 4)) (and (= x 13) (= y 8) (= z 4)) (and (= x 6) (= y 5) (= z 4)) (and (= x 12) (= y 8) (= z 5))
		(and (= x 14) (= y 9) (= z 5)) (and (= x 13) (= y 9) (= z 6)) (and (= x 15) (= y 10) (= z 6)) (and (= x 9) (= y 8) (= z 7)) (and (= x 10) (= y 9) (= z 8))
		(and (= x 13) (= y 12) (= z 11)) (and (= x 14) (= y 13) (= z 12)) (and (= x 15) (= y 14) (= z 13)) 
	)
)


; jump from X to Z
; X Y ~Z => ~X ~Y Z
;TRANS
(define-fun TRANS ((A (Array Int Bool)) (X Int) (Y Int) (Z Int) (As (Array Int Bool))) Bool
	(and
		(TRUPLE X Y Z)
		(select A X) (select A Y) (not (select A Z))
		(= 
			(store (store (store A X false) Y false) Z true) 
			As
		)
	)
)

(assert (START A0))
(assert (END A13))

(assert (TRANS A0 x0 y0 z0 A1))
(assert (TRANS A1 x1 y1 z1 A2))
(assert (TRANS A2 x2 y2 z2 A3))
(assert (TRANS A3 x3 y3 z3 A4))
(assert (TRANS A4 x4 y4 z4 A5))
(assert (TRANS A5 x5 y5 z5 A6))
(assert (TRANS A6 x6 y6 z6 A7))
(assert (TRANS A7 x7 y7 z7 A8))
(assert (TRANS A8 x8 y8 z8 A9))
(assert (TRANS A9 x9 y9 z9 A10))
(assert (TRANS A10 x10 y10 z10 A11))
(assert (TRANS A11 x11 y11 z11 A12))
(assert (TRANS A12 x12 y12 z12 A13))


(check-sat)
(get-value 
		(
			(select A0 1) (select A0 2) (select A0 3) (select A0 4) (select A0 5) (select A0 6) (select A0 7) (select A0 8)
			(select A0 9) (select A0 10) (select A0 11) (select A0 12) (select A0 13) (select A0 14) (select A0 15)
			(select A1 1) (select A1 2) (select A1 3) (select A1 4) (select A1 5) (select A1 6) (select A1 7) (select A1 8)
			(select A1 9) (select A1 10) (select A1 11) (select A1 12) (select A1 13) (select A1 14) (select A1 15)
			(select A2 1) (select A2 2) (select A2 3) (select A2 4) (select A2 5) (select A2 6) (select A2 7) (select A2 8)
			(select A2 9) (select A2 10) (select A2 11) (select A2 12) (select A2 13) (select A2 14) (select A2 15)
			(select A8 1) (select A8 2) (select A8 3) (select A8 4) (select A8 5) (select A8 6) (select A8 7) (select A8 8)
			(select A8 9) (select A8 10) (select A8 11) (select A8 12) (select A8 13) (select A8 14) (select A8 15)
			(select A9 1) (select A9 2) (select A9 3) (select A9 4) (select A9 5) (select A9 6) (select A9 7) (select A9 8)
			(select A9 9) (select A9 10) (select A9 11) (select A9 12) (select A9 13) (select A9 14) (select A9 15)
			(select A10 1) (select A10 2) (select A10 3) (select A10 4) (select A10 5) (select A10 6) (select A10 7) (select A10 8)
			(select A10 9) (select A10 10) (select A10 11) (select A10 12) (select A10 13) (select A10 14) (select A10 15)
			(select A13 1) (select A13 2) (select A13 3) (select A13 4) (select A13 5) (select A13 6) (select A13 7) (select A13 8)
			(select A13 9) (select A13 10) (select A13 11) (select A13 12) (select A13 13) (select A13 14) (select A13 15)
		)
)