;A very special island is inhabited only by knights and knaves. Knights
;always tell the truth, and knaves always lie.
;You meet three inhabitants: Zed, Ted and Zippy. Zed claims that it’s
;false that Zippy is a knave. Ted says, “Either Zippy is a knight or I am a
;knight.” Zippy says that Ted is a knave.
;You know that not all of these three inhabitants are knaves and not all of
;them are knights. Can you uniquely determine from the above information
;who is a knight and who is a knave?

(declare-datatypes () ((INHABITANTS Zed Ted Zippy)))
(declare-fun C (INHABITANTS) Bool)
(declare-fun F (INHABITANTS) Bool)

(assert (forall ((x INHABITANTS)) (= (C x) (not (F x)))))

(assert (and (not (and (C Zed) (C Ted) (C Zippy))) (not (and (F Zed) (F Ted) (F Zippy))))) 

(assert (= (C Zed) (not (F Zippy))))   

(assert (= (C Ted) (xor (C Zippy) (C Ted))))

(assert (= (C Zippy) (F Ted)))

(check-sat)
(get-value ((C Zed) (C Ted) (C Zippy) (F Zed) (F Ted) (F Zippy)))

(assert (not (and (F Zed) (F Zippy) (C Ted))))
(check-sat)
;the solution is unique