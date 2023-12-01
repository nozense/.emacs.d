;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Machine specific settings for station - nozenseLinux ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;
;;                ;;
;; My own scripts ;;
;;                ;;
;;;;;;;;;;;;;;;;;;;;

(load "myElisp")
(global-set-key
 (kbd "C-c j")
 (lambda () (interactive)
   (one_file_journal)
   (org-narrow-to-element)))


;;;;;;;;;;;;;;;;;;
;;              ;;
;; ORG-captures ;;
;;              ;;
;;;;;;;;;;;;;;;;;;

(setq org-capture-templates
      '(("t" "TODO" entry (file+datetree "~/org/journals/todo.org")
         "* TODO %?\n %i")
        ("l" "LOG" entry (file+datetree "~/org/journals/journal.org" "Log")
         "* %?\nAdded: %U\n %i")
        ("q" "Quick" entry (file+headline "~/org/inbox.org" "InBox")
         "* %U %?\n %i")
        ("m" "TODO imorgon" entry (file+datetree "~/org/journals/todo.org")
         "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+1d\"))\n %i")
        ("w" "Link to webpage" entry (file+headline "~/org/nozen.se/index.org" "Random Links")
         "* [[?][%?]]\n")
        ("b" "Blogg" entry (file myCreateBlogFileWithDate)
         "* %?\nSkapat: %U\n\n %i")
        ("r" "Recipe" entry
         (file+headline "~/org/data/recept.org" "Nya Recept")
         "* %?
              :PROPERTIES:
              :Författare:
              :Källa:
              :Portioner:
              :Förberedelse:
              :Tillagning:
              :Total_tid:
              :Beskrivning:
              :URL:
              :Sparat: %u
              :END:

              ""* Ingredienser:""
              - [ ] ?

              ""* Tillagning:""

              " :jump-to-captured t)))

;; Make a cusom agenda for non-schedueled todos
(setq org-agenda-custom-commands
      '(("c" . "Custom Agendas")
        ("cu" "Unscheduled TODO"
         ((todo ""
                ((org-agenda-overriding-header "\nUnscheduled TODO")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
         nil
         nil)))


;;;;;;;;;
;;     ;;
;; END ;;
;;     ;;
;;;;;;;;;
