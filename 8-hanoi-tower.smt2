;Solve the Hanoi tower problem as explained in 
;https://www.mathsisfun.com/games/towerofhanoi.html


(declare-const A0 (List Int))
(declare-const B0 (List Int))
(declare-const C0 (List Int))
(declare-const A1 (List Int))
(declare-const B1 (List Int))
(declare-const C1 (List Int))
(declare-const A2 (List Int))
(declare-const B2 (List Int))
(declare-const C2 (List Int))
(declare-const A3 (List Int))
(declare-const B3 (List Int))
(declare-const C3 (List Int))
(declare-const A4 (List Int))
(declare-const B4 (List Int))
(declare-const C4 (List Int))
(declare-const A5 (List Int))
(declare-const B5 (List Int))
(declare-const C5 (List Int))
(declare-const A6 (List Int))
(declare-const B6 (List Int))
(declare-const C6 (List Int))
(declare-const A7 (List Int))
(declare-const B7 (List Int))
(declare-const C7 (List Int))


;+---+ +---+ +---+
;| 1 | |   | |   |
;+---+ +---+ +---+
;| 2 | |   | |   |
;+---+ +---+ +---+
;| 3 | |   | |   |
;|___|_|___|_|___|
;  A     B     C

(define-fun START ( (A (List Int)) (B (List Int)) (C (List Int) ) ) Bool 
	(and
		(= A (insert 1 (insert 2 (insert 3 nil))))
		(= B nil)
		(= C nil)
	)
)

(define-fun END ( (A (List Int)) (B (List Int)) (C (List Int) ) ) Bool 
	(and
		(= C (insert 1 (insert 2 (insert 3 nil))))
		(= B nil)
		(= A nil)
	)
)


(define-fun TRANS ( (A (List Int)) (B (List Int)) (C (List Int)) (As (List Int)) (Bs (List Int)) (Cs (List Int)) ) Bool
		(or
			(and (< (head A) (head B))  (= As (tail A)) (= Bs (insert (head A) B)) (= Cs C))
			(and (< (head A) (head C))  (= As (tail A)) (= Cs (insert (head A) C)) (= Bs B))
			(and (< (head B) (head A))  (= Bs (tail B)) (= As (insert (head B) A)) (= Cs C))
			(and (< (head B) (head C))  (= Bs (tail B)) (= Cs (insert (head B) C)) (= As A))
			(and (< (head C) (head A))  (= Cs (tail C)) (= As (insert (head C) A)) (= Bs B))
			(and (< (head C) (head B))  (= Cs (tail C)) (= Bs (insert (head C) B)) (= As A))
		)
)

(assert (START A0 B0 C0))

(assert (TRANS A0 B0 C0 A1 B1 C1))
(assert (TRANS A1 B1 C1 A2 B2 C2))
(assert (TRANS A2 B2 C2 A3 B3 C3))
(assert (TRANS A3 B3 C3 A4 B4 C4))
(assert (TRANS A4 B4 C4 A5 B5 C5))
(assert (TRANS A5 B5 C5 A6 B6 C6))

(push)
(assert (END A6 B6 C6))
(check-sat)
(pop)

(assert (TRANS A6 B6 C6 A7 B7 C7))

(assert (END A7 B7 C7))
(check-sat)
(get-value (A0 B0 C0 A1 B1 C1 A2 B2 C2 A3 B3 C3 A4 B4 C4 A5 B5 C5 A6 B6 C6 A7 B7 C7)) 