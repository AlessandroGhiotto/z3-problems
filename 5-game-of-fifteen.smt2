;starting position:
;---------------------
;| 1  | 2  | 3  | 4  |
;---------------------
;| 5  | 6  | 7  | 8  |
;---------------------
;| 9  | 10 | 11 | 12 |
;---------------------
;| 13 | 14 | 15 | '0' |
;---------------------

;You can move the numbers by sliding them (vertically or horizontally) 
;in the next cell as long as it is empty. Not all configurations are 
;reachable in this way. Show that the following is reachable:

;---------------------
;| 1  | 3  | 6  | 4  |
;---------------------
;| 5  | 2  | 8  | 12 |
;---------------------
;| 9  | 10 | 7  | 15 |
;---------------------
;| 13 | 14 | 11 |    |
;---------------------


(declare-const A0 (Array Int Int))
(declare-const I0 Int)
(declare-const J0 Int)
(declare-const A1 (Array Int Int))
(declare-const I1 Int)
(declare-const J1 Int)
(declare-const A2 (Array Int Int))
(declare-const I2 Int)
(declare-const J2 Int)
(declare-const A3 (Array Int Int))
(declare-const I3 Int)
(declare-const J3 Int)
(declare-const A4 (Array Int Int))
(declare-const I4 Int)
(declare-const J4 Int)
(declare-const A5 (Array Int Int))
(declare-const I5 Int)
(declare-const J5 Int)
(declare-const A6 (Array Int Int))
(declare-const I6 Int)
(declare-const J6 Int)
(declare-const A7 (Array Int Int))
(declare-const I7 Int)
(declare-const J7 Int)
(declare-const A8 (Array Int Int))
(declare-const I8 Int)
(declare-const J8 Int)
(declare-const A9 (Array Int Int))
(declare-const I9 Int)
(declare-const J9 Int)
(declare-const A10 (Array Int Int))
(declare-const I10 Int)
(declare-const J10 Int)

;START
(define-fun START ( (A (Array Int Int)) ) Bool
	(and
		(= (select A 1) 1)
		(= (select A 2) 2)
		(= (select A 3) 3)
		(= (select A 4) 4)
		(= (select A 5) 5)
		(= (select A 6) 6)
		(= (select A 7) 7)
		(= (select A 8) 8)
		(= (select A 9) 9)
		(= (select A 10) 10)
		(= (select A 11) 11)
		(= (select A 12) 12)
		(= (select A 13) 13)
		(= (select A 14) 14)
		(= (select A 15) 15)
		(= (select A 16) 0)
	)
)

;END
(define-fun END ( (A (Array Int Int)) ) Bool
	(and
		(= (select A 1) 1)
		(= (select A 2) 3)
		(= (select A 3) 6)
		(= (select A 4) 4)
		(= (select A 5) 5)
		(= (select A 6) 2)
		(= (select A 7) 8)
		(= (select A 8) 12)
		(= (select A 9) 9)
		(= (select A 10) 10)
		(= (select A 11) 7)
		(= (select A 12) 15)
		(= (select A 13) 13)
		(= (select A 14) 14)
		(= (select A 15) 11)
		(= (select A 16) 0)
	)
)

;OrizontallyAdjacent
(define-fun OA ( (x Int)  (y Int) ) Bool
    (and 
		(<= 1 x) (<= x 16) (<= 1 y) (<= y 16)
		(= x (- y 1)) (not (or (= x 4) (= x 8) (= x 12)))
	)
)
;VerticallyAdjacent
(define-fun VA ( (x Int)  (y Int) ) Bool
	(and
		(<= 1 x) (<= x 12)
		(= x (- y 4))
	)
)

;SWAP
(define-fun SWAP ( (A (Array Int Int)) (I Int)  (J Int) ) (Array Int Int)
     (store (store A J (select A I)) I (select A J))
)

;TRANS
(define-fun TRANS ((A (Array Int Int)) (I Int) (J Int) (As (Array Int Int))) Bool
	(and
		(or (= (select A J) 0) (= (select A I) 0))
		(or (VA I J) (OA I J) (VA J I) (OA J I))
		(= (SWAP A I J) As)
	)
)

(assert (START A0))
(assert (END A10))

(assert (TRANS A0 I0 J0 A1))
(assert (TRANS A1 I1 J1 A2))
(assert (TRANS A2 I2 J2 A3))
(assert (TRANS A3 I3 J3 A4))
(assert (TRANS A4 I4 J4 A5))
(assert (TRANS A5 I5 J5 A6))
(assert (TRANS A6 I6 J6 A7))
(assert (TRANS A7 I7 J7 A8))
(assert (TRANS A8 I8 J8 A9))
(assert (TRANS A9 I9 J9 A10))


(check-sat)
(get-value 
		(
			(select A8 1) (select A8 2) (select A8 3) (select A8 4) (select A8 5) (select A8 6) (select A8 7) (select A8 8)
			(select A8 9) (select A8 10) (select A8 11) (select A8 12) (select A8 13) (select A8 14) (select A8 15) (select A8 16)
			(select A9 1) (select A9 2) (select A9 3) (select A9 4) (select A9 5) (select A9 6) (select A9 7) (select A9 8)
			(select A9 9) (select A9 10) (select A9 11) (select A9 12) (select A9 13) (select A9 14) (select A9 15) (select A9 16)
			(select A10 1) (select A10 2) (select A10 3) (select A10 4) (select A10 5) (select A10 6) (select A10 7) (select A10 8)
			(select A10 9) (select A10 10) (select A10 11) (select A10 12) (select A10 13) (select A10 14) (select A10 15)  (select A10 16)
		)	
)