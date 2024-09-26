;Show the impossibility of solving the celebrated Konigsberg 7 bridges
;problem. 

;ub=upper-bank, lb=lower-bank, 
;i1=island1, i2=island2
;b=bridge

; ub --b1-- i1
; ub --b3-- i1
; ub --b6-- i2
; lb --b2-- i1
; lb --b4-- i1
; lb --b7-- i2
; i1 --b5-- i2

;The problem is to devise a walk through the city that would cross each of
;those bridges once and only once


(declare-datatypes () ((BRIDGE b1 b2 b3 b4 b5 b6 b7)))
(declare-datatypes () ((LOCATION lb ub i1 i2)))
;mark the visited bridges
(declare-const V0 (Array BRIDGE Bool))
(declare-const V1 (Array BRIDGE Bool))
(declare-const V2 (Array BRIDGE Bool))
(declare-const V3 (Array BRIDGE Bool))
(declare-const V4 (Array BRIDGE Bool))
(declare-const V5 (Array BRIDGE Bool))
(declare-const V6 (Array BRIDGE Bool))
(declare-const V7 (Array BRIDGE Bool))
;p indicates what bridge I pass
(declare-const p0 BRIDGE)
(declare-const p1 BRIDGE)
(declare-const p2 BRIDGE)
(declare-const p3 BRIDGE)
(declare-const p4 BRIDGE)
(declare-const p5 BRIDGE)
(declare-const p6 BRIDGE)
(declare-const p7 BRIDGE)
;l indicates what location I am
(declare-const l0 LOCATION)
(declare-const l1 LOCATION)
(declare-const l2 LOCATION)
(declare-const l3 LOCATION)
(declare-const l4 LOCATION)
(declare-const l5 LOCATION)
(declare-const l6 LOCATION)
(declare-const l7 LOCATION)


;START
(assert
	(not
		(or
			(select V0 b1) (select V0 b2) (select V0 b3) (select V0 b4) (select V0 b5) (select V0 b6) (select V0 b7)
		)
	)
)

;TRANS
(define-fun TRANS ( (V (Array BRIDGE Bool)) (l LOCATION) (p BRIDGE) (Vs (Array BRIDGE Bool)) (ls LOCATION) ) Bool
	(or
		(and (= l lb) (= p b2) (= ls i1) (not (select V p)) (= (store V p true) Vs)) 
		(and (= l lb) (= p b4) (= ls i1) (not (select V p)) (= (store V p true) Vs)) 
		(and (= l lb) (= p b7) (= ls i2) (not (select V p)) (= (store V p true) Vs))
		(and (= l i1) (= p b2) (= ls lb) (not (select V p)) (= (store V p true) Vs))
		(and (= l i1) (= p b4) (= ls lb) (not (select V p)) (= (store V p true) Vs))
		(and (= l i1) (= p b5) (= ls i2) (not (select V p)) (= (store V p true) Vs))
		(and (= l i1) (= p b1) (= ls ub) (not (select V p)) (= (store V p true) Vs))
		(and (= l i1) (= p b3) (= ls ub) (not (select V p)) (= (store V p true) Vs))
		(and (= l i2) (= p b5) (= ls i1) (not (select V p)) (= (store V p true) Vs))
		(and (= l i2) (= p b6) (= ls ub) (not (select V p)) (= (store V p true) Vs))
		(and (= l i2) (= p b7) (= ls lb) (not (select V p)) (= (store V p true) Vs))
		(and (= l ub) (= p b1) (= ls i1) (not (select V p)) (= (store V p true) Vs))
		(and (= l ub) (= p b3) (= ls i1) (not (select V p)) (= (store V p true) Vs))
		(and (= l ub) (= p b6) (= ls i2) (not (select V p)) (= (store V p true) Vs))
	)
)


(assert (TRANS V0 l0 p0 V1 l1))
(assert (TRANS V1 l1 p1 V2 l2))
(assert (TRANS V2 l2 p2 V3 l3))
(assert (TRANS V3 l3 p3 V4 l4))
(assert (TRANS V4 l4 p4 V5 l5))
(assert (TRANS V5 l5 p5 V6 l6))

(check-sat)

(assert (TRANS V6 l6 p6 V7 l7))
(check-sat)
