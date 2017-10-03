(deftemplate ALUMNO
	(slot nombre)
	(slot mates)
	(slot fisica)
	(slot ayudar)
	(slot problemas)
	(slot dibujar)
	(slot dificil)
	(slot esfuerzo)
	(slot eleccion (default nil)))
	
(do-backward-chaining ALUMNO)	
	
(deffacts a 
	(ALUMNO (nombre Jose) (mates si) (fisica si))
	(ALUMNO (nombre David) (ayudar si) (esfuerzo mucho) (dificil si))
	(ALUMNO (nombre Daniel) (ayudar no) (problemas si))
	(ALUMNO (nombre Tania) (esfuerzo poco) (dificil no))
	(ALUMNO (nombre Marina) (mates no) (fisica no)))

(defrule medicina_rule
	(declare (salience 400) (no-loop TRUE))
	?alum <- (ALUMNO (nombre ?nom)(ayudar si) (mates no) (dificil si) (esfuerzo mucho))
		=>	(modify ?alum (eleccion medicina))
			(printout t "El alumno " ?nom  " quiere estudiar medicina" crlf))


(defrule informatica_rule
	(declare (salience 400) (no-loop TRUE) )
	?alum <- (ALUMNO (nombre ?nom) (mates si) (fisica si) (ayudar no) (problemas si))
		=>	(modify ?alum (eleccion informatica))
			(printout t "El alumno " ?nom  " quiere estudiar ingenieria informatica" crlf))

(defrule bellas_artes_rule
	(declare (salience 400) (no-loop TRUE))
	?alum <- (ALUMNO (nombre ?nom) (dibujar si) (mates no) (fisica no) (dificil no))
		=>	(modify ?alum (eleccion bellas artes))
			(printout t "El alumno " ?nom  " quiere estudiar bellas artes" crlf))

(defrule biomedica_rule
	(declare (salience 400) (no-loop TRUE) )
	?alum <- (ALUMNO (nombre ?nom) (mates si) (fisica si) (ayudar si) (problemas si) (dificil si)(esfuerzo mucho))
		=>	(modify ?alum (eleccion biomedica))
			(printout t "El alumno " ?nom  " quiere estudiar ingenieria biomedica" crlf))
	
(defrule magisterio_rule
	(declare (salience 400) (no-loop TRUE) )
	?alum <- (ALUMNO (nombre ?nom) (dificil no) (ayudar si) (problemas no) (esfuerzo poco))
		=> 	(modify ?alum (eleccion magisterio))
			(printout t "El alumno " ?nom  " quiere estudiar magisterio" crlf))

(defrule no_solucion
    (declare (salience -9999))
    ?alum <-(ALUMNO (nombre ?nom) (eleccion nil))
		=>
        (printout t "No se sabe lo que quiere estudiar el alumno " ?nom " " crlf))


; DERIVACIONES

(defrule dificil_deb
	(declare (salience 100))
	?alum <- (ALUMNO (problemas si) (esfuerzo mucho) (eleccion nil))
		=>	(modify ?alum (dificil si)))
	
(defrule dificil_deb2
	(declare (salience 100))
	?alum <- (ALUMNO (mates no) (fisica no) (eleccion nil))
		=>	(modify ?alum (dificil no))) 

(defrule esfuerzo_deb
	(declare (salience 100))
	?alum <- (ALUMNO (fisica si) (mates si) (eleccion nil))
		=>	(modify ?alum (esfuerzo mucho)))
	
(defrule problemas_deb
	(declare (salience 100))
	?alum <- (ALUMNO (fisica si) (mates si) (eleccion nil))
		=>	(modify ?alum (problemas si)))
	
(defrule problemas_deb2
	(declare (salience 100))
	?alum <- (ALUMNO (dificil no) (esfuerzo poco) (eleccion nil))
		=>	(modify ?alum (problemas no)))
	
; PREGUNTAS

(defrule pregunta_mates
	(declare (salience 50))
	(exists (need-ALUMNO (nombre ?nom) (mates nil) ) )
	?alum <- (ALUMNO (nombre ?nom) (mates nil) (eleccion nil))
		=>	(printout t "¿A " ?nom " le gustan las matematicas? (si/no)")
			(modify ?alum (mates (read))))
	
(defrule pregunta_fisica
	(declare (salience 20))
	(exists (need-ALUMNO (nombre ?nom) (fisica nil) ) )
	?alum <- (ALUMNO (nombre ?nom) (fisica nil) (eleccion nil))
		=>	(printout t "¿A " ?nom " le gusta la fisica? (si/no)")
			(modify ?alum (fisica (read))))
	
(defrule pregunta_ayudar
	(declare (salience 20))
	(exists (need-ALUMNO (nombre ?nom) (ayudar nil) ) )
	?alum <- (ALUMNO (nombre ?nom) (ayudar nil) (eleccion nil))
		=>	(printout t "¿A " ?nom " le gusta ayudar a la sociedad? (si/no)")
			(modify ?alum (ayudar (read))))
	
(defrule pregunta_problemas
	(declare (salience 0))
	(exists (need-ALUMNO (nombre ?nom) (problemas nil) ) )
	?alum <- (ALUMNO (nombre ?nom) (problemas nil) (eleccion nil))
		=>	(printout t "¿A " ?nom " le gusta resolver problemas? (si/no)")
			(modify ?alum (problemas (read))))
	
(defrule pregunta_dibujar
	(declare (salience 20))
	(exists (need-ALUMNO (nombre ?nom) (dibujar nil) ) )
	?alum <- (ALUMNO (nombre ?nom) (dibujar nil) (eleccion nil))
		=>	(printout t "¿A " ?nom " le gusta dibujar? (si/no)")
			(modify ?alum (dibujar (read))))
	
(defrule pregunta_dificil
	(declare (salience 0))
	(exists (need-ALUMNO (nombre ?nom) (dificil nil) ) )
	?alum <- (ALUMNO (nombre ?nom) (dificil nil) (eleccion nil))
		=>	(printout t "¿A " ?nom " le gustan los retos dificiles? (si/no)")
			(modify ?alum (dificil (read))))
	
(defrule pregunta_esfuerzo
	(declare (salience 0))
	(exists (need-ALUMNO (nombre ?nom) (esfuerzo nil) ) )
	?alum <- (ALUMNO (nombre ?nom) (esfuerzo nil) (eleccion nil))
		=>	(printout t "¿Consideras que " ?nom "  es constante en los estudios? (mucho/poco)")
			(modify ?alum (esfuerzo (read))))
	
(reset)
(facts)
(run)