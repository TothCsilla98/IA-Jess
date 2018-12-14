;(bind ?A 2)
;(bind ?B 3)
;(bind ?C 7)
;(bind ?D 1001)
;
;(printout t (+ ?A ?B ?C ?D))

(deftemplate element (slot valoare) (slot nume))

(assert(element(valoare 1)(nume A)))
(assert(element(valoare 2)(nume B)))
(assert(element(valoare 3)(nume C)))
(assert(element(valoare 4)(nume D)))

(deftemplate suma (slot valoare))
	(assert (suma (valoare 0)))

(defrule CalculSuma
    ?idve <- (element (valoare ?ve))
    ?idvs <- (suma (valoare ?vs))
    =>
    (modify ?idvs (valoare (+ ?ve ?vs)))
    (retract ?idve)
)

(defrule AfisareSuma
    (suma (valoare ?vs))
    =>
    (printout t " Suma = "?vs crlf)
)

;(watch all)
(run)
;(facts)

(deffunction suma($?elemente)
    (bind ?sum 0)
    
    (foreach ?n $?elemente
        (bind ?sum (+ ?sum ?n))
    )
    
    (return ?sum)
)

(printout t "suma functie = " (suma 1 2 3) crlf )
(run)