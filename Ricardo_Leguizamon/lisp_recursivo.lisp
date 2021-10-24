(defvar lista (list 5 80 2 24 10 50 30 12 5 11))
(defvar max (car lista))
(defvar min (car lista))
(defvar suma 0)
(defvar count 0)
(defun maximo (lista)
    (setq a (car lista))
    (if (> a max)(setq max a)) ;si es mayor a max max = a
    (if (null (cdr lista)) 
        max
        (maximo (cdr lista));llamada recusiva
    )
)
(defun minimo (lista) 
    (setq a (car lista))
    (if (< a min)(setq min a)) ; lo mismo para max pero cambiando el sentido de ordenamiento 
    (if (null (cdr lista))
        min
        (minimo (cdr lista))
    )
)
(defun prom(lista)
    (setq a(car lista))
    (setq suma (+ suma a))
    (setq count (+ count 1))

    (if (null (cdr lista))
        (/ suma count)
        (prom (cdr lista))
    )
)
;llamada a funciones
(write-line "maximo valor: ")
(write(maximo lista))
(write-line " ")
(write-line "minimo valor")
(write (minimo lista))
(write-line " ")
(write-line "el promedio: ")
(write (prom lista))
(write-line " ")