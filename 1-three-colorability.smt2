;Show that 3 colors are sufficient to color the part of the European
;map that includes the following sets of countries: Italy, Austria, 
;Switzerland, France, Germany. 

;declare sort
(declare-sort D)
;declare one function for every color, unary predicates
(declare-fun C1 (D) Bool)
(declare-fun C2 (D) Bool)
(declare-fun C3 (D) Bool)
;function for the adjacency relation, binary predicates
(declare-fun R (D D) Bool)
;declare one const for every country
(declare-const Italia D)
(declare-const Svizzera D)
(declare-const Austria D)
(declare-const Francia D)
(declare-const Germania D)
;.................................................

;a function that is true when are true only 1 out of 3 variables
;define-fun means that is a macro
(define-fun oneout3 ((x Bool) (y Bool) (z Bool)) Bool
					(or
						(and x (not y) (not z))
						(and (not x)  y (not z))
						(and (not x) (not y) z)
					)
)

;one country can have only 1 color out of 3
(assert (forall ((x D)) (oneout3 (C1 x) (C2 x) (C3 x))))

;.................................................
;I have to put constraints for every couple of country that are adjacent
;A is adjacent to B iff B is adjacent to A
(assert (forall ((x D) (y D)) (= (R x y) (R y x))))

;Adjacent countries:
(assert (R Italia Svizzera))
(assert (R Italia Francia))
(assert (R Italia Austria))
(assert (R Francia Svizzera))
(assert (R Francia Germania))
(assert (R Germania Austria))
(assert (R Germania Svizzera))
(assert (R Austria Svizzera))



;all couple of adjacents countries can't have the same color:
(assert (forall ((x D) (y D))
				(=>
					(R x y)
					(not (or 
							(and (C1 x) (C1 y))
							(and (C2 x) (C2 y))
							(and (C3 x) (C3 y))
						 )
					)
				)
		)
)
;That's equal to:
;(assert (forall ((x D) (y D)) (=> (R x y) (not (and (C1 x) (C1 y))))))
;(assert (forall ((x D) (y D)) (=> (R x y) (not (and (C2 x) (C2 y))))))
;(assert (forall ((x D) (y D)) (=> (R x y) (not (and (C3 x) (C3 y))))))


(check-sat)
(get-value ((C1 I) (C2 I) (C3 I) 
			(C1 S) (C2 S) (C3 S) 
			(C1 A) (C2 A) (C3 A) 
			(C1 F) (C2 F) (C3 F) 
			(C1 G) (C2 G) (C3 G)
		    )
)