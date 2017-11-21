(deftemplate temperatura -10 50 grados
 (
    (baja  (16 1) (21 0))
    (bien  (15 0) (19 1) (26 1) (31 0))
    (calor (21 0) (30 1))
 ))

(deftemplate viento 0 100 kph
 (
    (calma (1 1) (5 0))
    (brisa (2 0) (20 1) (39 1) (49 0))
    (viento (25 0) (39 1) (62 1) (74 0))
    (temporal (62 0) (74 1))
 ))

(deftemplate calorsolar 0 75 grados
 (
    (bajo  (0  1) (35 0))
    (medio (30 0) (40 1) (50 1) (60 0))
    (alto  (55 0) (60 1))
 ))

(deftemplate termostato -10 10 grados-por-minuto
 (
    (off (-0.5 0) (0 1) (0.5 0))
    (enfriar (-6 0) (-4 1) (-2 1) (0 0))
    (enfriar-mucho (-10 1) (-5 0))
    (calentar (0 0) (2 1) (4 1) (6 0))
    (calentar-mucho (5 0) (10 1))
 )
)

(deftemplate toldo 0 1 porcentaje
 (
    (cerrado (0 1) (0.05 0))
    (medio (0 0) (0.5 1) (1 0))
    (abierto (0.5 0) (0.8 1))
 )
)

(deftemplate estado
    (slot temp (FUZZY-VALUE temperatura))
    (slot wind (FUZZY-VALUE viento))
    (slot heat (FUZZY-VALUE calorsolar))
)

(deftemplate solucionTermo
    (slot solTermo (FUZZY-VALUE termostato))
)

(deftemplate solucionToldo
    (slot solToldo (FUZZY-VALUE toldo))
)

(deffacts initial
    (solucionToldo (solToldo nil))
    (solucionTermo (solTermo nil))
    (estado (temp bien) (wind viento) (heat alto)
)

(defrule solved
    (solucionToldo (solToldo ?t1))
    (solucionTermo (solTermo ?t2))
    =>
    (printout t "El toldo esta " ?t1 "cm abierto" crlf)
    (printout t "El termostato esta cambiando la temperatura " ?t2 "º por minuto" crlf)
    (halt)
)

(defrule too-windy-or-cold
    (define (salience 10))
    (or
        (estado (wind temporal))
        (estado (temp baja))
    )
    ?f <- (solucionToldo (solToldo nil))
    =>
    (assert (solucionToldo (solToldo cerrado)))
    (retract ?f)
)

(defrule too-hot
    (define (salience 5))
    (estado (temp calor))
    ?f <- (solucionToldo (solToldo nil))
    =>
    (assert (solucionToldo (solToldo abierto)))
    (retract ?f)
)

(defrule toldo-calor-bajo
    (estado (heat bajo))
    ?f <- (solucionToldo (solToldo nil))
    =>
    (assert (solucionToldo (solToldo cerrado)))
    (retract ?f)
)

(defrule toldo-calor-medio
    (estado (heat medio))
    ?f <- (solucionToldo (solToldo nil))
    =>
    (assert (solucionToldo (solToldo medio)))
    (retract ?f)
)

(defrule toldo-calor-alto
    (estado (heat alto))
    ?f <- (solucionToldo (solToldo nil))
    =>
    (assert (solucionToldo (solToldo abierto)))
    (retract ?f)
)

(defrule enfriar
    (define (salience 10))
    (or
        (estado (temp calor) (heat bajo))
        (estado (temp calor) (heat medio))
    )
    ?f <- (solucionTermo (solTermo nil))
    =>
    (assert (solucionTermo (solTermo enfriar)))
    (retract ?f)
)

(defrule enfriar-mucho
    (define (salience 10))
    (estado (temp calor)(heat alto))
    ?f <- (solucionTermo (solTermo nil))
    =>
    (assert (solucionTermo (solTermo enfriar-mucho)))
    (retract ?f)
)

(defrule calentar-mucho
    (define (salience 10))
    (estado (temp baja))
    (or
        (estado (heat medio))
        (estado (heat bajo))
    )
    ?f <- (solucionTermo (solTermo nil))
    =>
    (assert (solucionTermo (solTermo calentar-mucho)))
    (retract ?f)
)

(defrule calentar
    (define (salience 10))
    (estado (temp baja))
    (estado (heat alto))
    ?f <- (solucionTermo (solTermo nil))
    =>
    (assert (solucionTermo (solTermo calentar)))
    (retract ?f)
)

(defrule off
    (define (salience 10))
    (estado (temp bien))
    (estado (heat medio))
    ?f <- (solucionTermo (solTermo nil))
    =>
    (assert (solucionTermo (solTermo off)))
    (retract ?f)
)

(defrule enfriar-poco
    (define (salience 10))
    (estado (temp bien))
    (estado (heat alto))
    ?f <- (solucionTermo (solTermo nil))
    =>
    (assert (solucionTermo (solTermo somewhat enfriar)))
    (retract ?f)
)

(defrule calentar-poco
    (define (salience 10))
    (estado (temp bien))
    (estado (heat bajo))
    ?f <- (solucionTermo (solTermo nil))
    =>
    (assert (solucionTermo (solTermo somewhat calentar)))
    (retract ?f)
)

