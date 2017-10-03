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
