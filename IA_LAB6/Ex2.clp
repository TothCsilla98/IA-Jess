(deftemplate element(slot item)(slot multime)(slot folosit(default FALSE)))
(assert (element (item 1)(multime A)))
(assert (element (item 2)(multime A)))
(assert (element (item 3)(multime A)))
(assert (element (item 4)(multime A)))
(assert (element (item 5)(multime A)))
(assert (element (item 6)(multime A)))
(assert (element (item 7)(multime A)))
(assert (element (item 8)(multime A)))
(assert (element (item 9)(multime A)))
(assert (element (item 10)(multime A)))
(assert (element (item 2)(multime B)))
(assert (element (item 4)(multime B)))
(assert (element (item 6)(multime B)))
(assert (element (item 8)(multime B)))
(assert (element (item 10)(multime B)))
(assert (element (item 12)(multime B)))

(defrule intersectie
    ?idmf <- (element (item ?i)(multime ?m)(folosit FALSE))
    ?idmfa <- (element (item ?i)(multime ?m1 & ~?m)(folosit FALSE))
    =>
    (modify ?idmf(folosit TRUE))
    (modify ?idmfa (folosit TRUE))
    (assert (element (item ?i)(multime I)))
    (printout t "Elemenetele multimi I " ?i crlf)
)

(run)

(deftemplate suma(slot valoare))

(assert (suma (valoare 0)))
(defrule duplicat
    ?idm <- (element (item ?i)(multime ?m & ~R)(folosit FALSE))
    ?idm1 <- (element (item ?i)(multime ?1 & ~?m & R)(folosit FALSE))
    =>
    (modify ?idm (folosit TRUE))
    (modify ?idm1 (folosit TRUE))
    (assert (element (item ?i)(multime R)))
)

(defrule reuniune
    ?idr <- (element (item ?i)(multime ?m & ~R)(folosit FALSE))
    =>
    (assert (element (item ?i)(multime R)))
    (modify ?idr (folosit TRUE))
)

(defrule printare
    (element (item ?i)(multime R)(folosit FALSE))
    =>
    (printout t "Elemenetele multimii R = " ?i crlf)
)

(defrule CalculSuma
    ?idi <- (element (item ?i))
    ?idvs <- (suma (valoare ?vs))
    (element (item ?i & :(> ?i 10) & :(< ?i 50)))
    =>
    (modify ?idvs (valoare (+ ?i ?vs)))
    (retract ?idi)
)

(defrule afisaresuma
    (suma (valoare ?vs))
    =>
    (printout t "suma = " ?vs crlf)
)


(deffunction suma($?lista)
    (bind ?sum 0)
    (foreach ?n $?lista
        (bind ?sum (+ ?sum ?n))
    )
    (return ?sum)
)

(printout t (suma 1 2 3) crlf)
(run)

