(define (problem ejemplo1caso1)
    (:domain ejemplo1)
    (:objects
        A - city
        B - city
        C - city
        D - city
        E - city

        p1 - package
        p2 - package

        c1 - truck
        c2 - truck

        d1 - driver
        d2 - driver)
    (:init
        (at p1 A)
        (at p2 D)
        (at c1 A)
        (at c2 A)
        (at d1 C)
        (at d2 D)

        (= (cost A B) 2)
        (= (time A B) 5)
        (= (cost A C) 1)
        (= (time A C) 3)
        (= (cost B C) 1)
        (= (time B C) 3)
        (= (cost B D) 2)
        (= (time B D) 2)
        (= (cost B E) 3)
        (= (time B E) 4)
        (= (cost C E) 5)
        (= (time C E) 8)

        (= (cost B A) 2)
        (= (time B A) 5)
        (= (cost C A) 1)
        (= (time C A) 3)
        (= (cost C B) 1)
        (= (time C B) 3)
        (= (cost D B) 2)
        (= (time D B) 2)
        (= (cost E B) 3)
        (= (time E B) 4)
        (= (cost E C) 5)
        (= (time E C) 8)

        (has-route A B)
        (has-route A C)
        (has-route B A)
        (has-route B C)
        (has-route B D)
        (has-route B E)
        (has-route C A)
        (has-route C B)
        (has-route C E)
        (has-route D B)
        (has-route E B)
        (has-route E C)

        (= (cost-bus) 3)
        (= (time-bus) 10)
        (= (cost-load) 1)
        (= (time-load) 1)
        (= (cost-unload) 1)
        (= (time-unload) 1)
        (= (cost-get-on) 1)
        (= (time-get-on) 1)
        (= (cost-get-off) 1)
        (= (time-get-off) 1)

        (= (total-cost) 0)
    )
    (:goal (and
        (at p1 E)
        (at p2 C)
        (at c2 A)
        (at d1 B)
    ))
    (:metric minimize (+ (* 0.1 (total-time)) (* 0.2 (total-cost))))
)
