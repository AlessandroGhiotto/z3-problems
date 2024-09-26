;A shepherd must ferry a wolf, a sheep, and a cabbage from one side of a
;river to the other. He may ferry a maximum of one of the three passengers at
;a time. He must not leave wolf and sheep, nor sheep and cabbage together
;without his supervision. How should he do this? What is the minimum
;number of crossings he needs?

; 0 the element is on the left
; 1 the element is on the right
; I create a constant for every element at every moment

(declare-const pa0 Bool)
(declare-const pe0 Bool)
(declare-const lu0 Bool)
(declare-const ca0 Bool)

(declare-const pa1 Bool)
(declare-const pe1 Bool)
(declare-const lu1 Bool)
(declare-const ca1 Bool)

(declare-const pa2 Bool)
(declare-const pe2 Bool)
(declare-const lu2 Bool)
(declare-const ca2 Bool)

(declare-const pa3 Bool)
(declare-const pe3 Bool)
(declare-const lu3 Bool)
(declare-const ca3 Bool)

(declare-const pa4 Bool)
(declare-const pe4 Bool)
(declare-const lu4 Bool)
(declare-const ca4 Bool)

(declare-const pa5 Bool)
(declare-const pe5 Bool)
(declare-const lu5 Bool)
(declare-const ca5 Bool)

(declare-const pa6 Bool)
(declare-const pe6 Bool)
(declare-const lu6 Bool)
(declare-const ca6 Bool)

(declare-const paF Bool)
(declare-const peF Bool)
(declare-const luF Bool)
(declare-const caF Bool)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; START (everyone on the left)
(assert (and (not pa0) (not pe0) (not lu0) (not ca0)))

; END (everyone on the right)
(assert (and paF peF luF caF))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; TRANSITION
; pa = pastore, pe = pecora, lu = lupo, ca = cavolo
; P = x at the Precedent timepoint, S = x at the Successiv timepoint

(define-fun Cross ((paP Bool) (peP Bool) (luP Bool) (caP Bool) (pa Bool) (pe Bool) (lu Bool) (ca Bool) (paS Bool) (peS Bool) (luS Bool) (caS Bool)) Bool 
		(and
			;CONSTRAINTS PECORA-LUPO, PECORA-CAVOLO
			(=> (= lu pe) (= pa pe))
			(=> (= ca pe) (= pa pe))
			(=> (= luS peS) (= paS peS))
			(=> (= caS peS) (= paS peS))
			
			;CHOICE OF CROSSING THE ROAD
			(or 
				;cross the pecora
				(and (= peS (not pe)) (= pa pe) (= paS peS) (= lu luS) (= ca caS))
				;cross the lupo
				(and (= luS (not lu)) (= pa lu) (= paS luS) (= pe peS) (= ca caS))
				;cross the cavolo
				(and (= caS (not ca)) (= pa ca) (= paS caS) (= lu luS) (= pe peS))
				;only the pastore
				(and (= paS (not pa)) (= ca caS) (= lu luS) (= pe peS))
			)
			
			; [5] RULE
			(not (and (= paP paS) (= peP peS) (= luP luS) (= caP caS)))
		)
)

; [5] RULE:
; this rule with the adding of (paP peP luP caP) allows me to not repeat the same move
; like go up-and-down that cause the same situation, so I get a solution only in 7 moves
; if I give him 9, 11 or 13 moves I get UNSAT because I can't have 0000, 1100, 0000

(assert (Cross pa0 pe0 lu0 ca0 pa0 pe0 lu0 ca0 pa1 pe1 lu1 ca1)) ;from t0 to t1
(assert (Cross pa0 pe0 lu0 ca0 pa1 pe1 lu1 ca1 pa2 pe2 lu2 ca2)) ;from t1 to t2
(assert (Cross pa1 pe1 lu1 ca1 pa2 pe2 lu2 ca2 pa3 pe3 lu3 ca3)) ;from t2 to t3
(assert (Cross pa2 pe2 lu2 ca2 pa3 pe3 lu3 ca3 pa4 pe4 lu4 ca4)) ;from t3 to t4
(assert (Cross pa3 pe3 lu3 ca3 pa4 pe4 lu4 ca4 pa5 pe5 lu5 ca5)) ;from t4 to t5
(assert (Cross pa4 pe4 lu4 ca4 pa5 pe5 lu5 ca5 pa6 pe6 lu6 ca6)) ;from t5 to t6
(assert (Cross pa5 pe5 lu5 ca5 pa6 pe6 lu6 ca6 paF peF luF caF)) ;from t6 to tF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(check-sat)
(get-value (pa0 pe0 lu0 ca0 pa1 pe1 lu1 ca1 pa2 pe2 lu2 ca2 pa3 pe3 lu3 ca3 pa4 pe4 lu4 ca4 pa5 pe5 lu5 ca5 pa6 pe6 lu6 ca6 paF peF luF caF))