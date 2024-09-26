;You are given the following 10 tiles: 
;[1|3] , [6|1] , [3|2] , [9|6] , [1|2],
;[4|9] , [2|6] , [2|4] , [6|1] , [2|2]. 
;Each tile has two cells, with numbers printed inside them. 
;Arrange the tiles in a square frame in such a way that two 
;adjacent cells from different tiles have the same number
;(or show that no such arrangement exists).

(declare-datatypes () ((Tiles t1 t2 t3 t4 t5 t6 t7 t8 t9 t10)))
(declare-fun Pos (Tiles) Int) ;Position
;(declare-fun Flip (Tiles) Bool) ;Flipped or not
(declare-fun L (Tiles) Int) ;number at the left
(declare-fun R (Tiles) Int) ;number at the right

;All tiles (My datas)
;can be flipped or not
(assert (or 
	(and (= (L t1) 1) (= (R t1) 3)) 
	(and (= (L t1) 3) (= (R t1) 1))))
(assert (or 
	(and (= (L t2) 6) (= (R t2) 1)) 
	(and (= (L t2) 1) (= (R t2) 6))))
(assert (or 
	(and (= (L t3) 3) (= (R t3) 2)) 
	(and (= (L t3) 2) (= (R t3) 3))))
(assert (or 
	(and (= (L t4) 9) (= (R t4) 6)) 
	(and (= (L t4) 6) (= (R t4) 9))))
(assert (or 
	(and (= (L t5) 1) (= (R t5) 2)) 
	(and (= (L t5) 2) (= (R t5) 1))))
(assert (or 
	(and (= (L t6) 4) (= (R t6) 9)) 
	(and (= (L t6) 9) (= (R t6) 4))))
(assert (or 
	(and (= (L t7) 2) (= (R t7) 6)) 
	(and (= (L t7) 6) (= (R t7) 2))))
(assert (or 
	(and (= (L t8) 2) (= (R t8) 4)) 
	(and (= (L t8) 4) (= (R t8) 2))))
(assert (or 
	(and (= (L t9) 6) (= (R t9) 1)) 
	(and (= (L t9) 1) (= (R t9) 6))))
(assert (and (= (L t10) 2) (= (R t10) 2)))


;injectivity
(assert (forall ((x Tiles) (y Tiles)) (=> (not (= x y)) (not (= (Pos x) (Pos y))))))

;10 positions
(assert (forall ((x Tiles)) (and (>= (Pos x) 1) (<= (Pos x) 10))))

;right of a tiles must be equal to the left of the next tiles
;(assert (forall ((i Int) (x Tiles) (y Tiles))
;		(=> (and (= (Pos x) i) (= (Pos y) (+ i 1))) (= (R x) (L y)))
;))

(assert (forall ((x Tiles) (y Tiles)) (=> (= (Pos x) (- (Pos y) 1)) (= (R x) (L y)))))
(assert (forall ((x Tiles) (y Tiles)) (=> (and (= (Pos x) 10) (= (Pos y) 1)) (= (R x) (L y)))))

(check-sat)
(get-value ((Pos t1) (Pos t2) (Pos t3) (Pos t4) (Pos t5) (Pos t6) (Pos t7) (Pos t8) (Pos t9) (Pos t10)))