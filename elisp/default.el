;; Check the name of the machine and load machine-specific settings

(if (string= (system-name)
	     "nozenlapz-UX430UAR")
    (load "nozenlapz") nil)

(if (string= (system-name)
	     "molndesk")
    (load "molndesk") nil)

(if (string= (system-name)
	     "nozenseLinux")
    (load "nozenseLinux") nil)


;;;;;;;;;;;;;;;;;;;;
;;                ;;
;; My own scripts ;;
;;                ;;
;;;;;;;;;;;;;;;;;;;;

(load "myElisp")
(global-set-key
 (kbd "C-c j")
 (lambda () (interactive)
   (myOneFileJournal)
   (org-narrow-to-element)))
(global-set-key
 (kbd "C-c s")
 (lambda () (interactive)
   (myCreateShortFictionFile)))


;; Make a cusom agenda for non-schedueled todos
(setq org-agenda-custom-commands
      '(("c" . "Custom Agendas")
        ("cu" "Unscheduled TODO"
         ((todo ""
                ((org-agenda-overriding-header "\nUnscheduled TODO")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
         nil
         nil)))
