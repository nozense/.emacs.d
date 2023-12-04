;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Machine specific settings for laptop - nozenlapz ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



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

;;;;;;;;;
;;     ;;
;; END ;;
;;     ;;
;;;;;;;;;
