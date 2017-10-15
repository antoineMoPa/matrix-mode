;; Other idea: lenny faces mode
(defun matrix-mode ()
  "Matrix screen mode"
  (interactive)
  (other-window 1)
  (switch-to-buffer "*matrix-mode*")
  (set-background-color "black")
  (set-foreground-color "green")
  (setq auto-window-vscroll nil)
  (setq scroll-step 1)
  (erase-buffer)
  
  (setq letters
	(concat "123456789abcdefghijklmnopqrstuvwxyz"
		"αΑβΒγΓδΔεΕζΖηΗθΘιΙκΚλΛμΜνΝξΞοΟπΠρΡσ"
		"ΣτΤυΥφΦχΧψΨωΩ"
		))
  (setq letters-length (length letters))
  
  (defun random-chars (number-of-chars)
    (let ((str ""))
      (dotimes (i number-of-chars)
	(setq str
	      (concat str
		      (string
		       (elt letters
			    (random
			     letters-length))))))
      str
      )
    )
  (defun fill-screen-initial (number-of-passes)
    ""
    (setq str "")
    (dotimes (current-pass number-of-passes)
      ;; delete line
      (if (> current-pass 0)
	  (progn
	    (goto-char 0)
	    (kill-line)
	    )
	)
      (dotimes (line-number (- (window-height) 1))
	(if (and (> current-pass 0) (< line-number (- (window-height) 2)))
	    (progn
	      (kill-line)
	      (kill-line)
	      )
	  )
	(setq str (random-chars (window-width)))
	
	(insert (if (< line-number (- (window-height) 2))
		    (concat str "\n")
		  str
		  )
		)
	(sit-for 0.01)
	)
      )
    )
  
  (defun fill-screen-1-by-1 (number-of-passes)
    ""
    (dotimes (current-pass number-of-passes)
      (goto-char 0)
      (setq particles '())
      (dotimes (numpart 10)
	(add-to-list 'particles (random (- (window-width) 1)) t)
	)
      (dotimes (line-number (- (window-height) 1))
	(goto-line line-number)
	(dolist (particle particles)
	  (move-to-column particle)
	  (delete-char 1)
	  (insert (random-chars 1)) 
	  (sit-for 0.001)
	  )
	
	;;(dotimes (column-number (- (window-width) 2))
	;;  (if (< -1 (random 10))
	;;      (progn
	;;	(delete-char 1)
	;;	(insert "a")
	;;	(sit-for 0.02)
	;;	)
	;;    (goto-char (+ 1 (point)))
	;;    )
	;;  
	;;  )
	)
      )
    )
  ;;(fill-screen-initial 1)
  (dotimes (line (window-height))
    (dotimes (col (- (window-width) 1))
      (insert " ")
      )
    (insert "\n")
    )
  (fill-screen-1-by-1 4)
  )
(matrix-mode)
