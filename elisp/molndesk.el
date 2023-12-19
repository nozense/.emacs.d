;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Machine specific settings for VPS - molndesk ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;
;; Dracula pro theme ;;
;;;;;;;;;;;;;;;;;;;;;;;

 (add-to-list 'custom-theme-load-path "~/org/draculaPRO/themes/emacs/")
   (load-theme 'dracula-pro-pro t)


;;;;;;;;;;;;;;;;;;
;;              ;;
;; DIV settings ;;
;;              ;;
;;;;;;;;;;;;;;;;;;

;; Have a problem with dracula-theme in MATE-terminal, TMP-FIX

(set-face-attribute 'org-hide nil :foreground "#666" :background "#444")

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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;; 
;; publish SETTINGS for NOZEN.SE ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load the publishing system
(require 'ox-publish)
;; Remove de "validate"-link from output
(setq org-html-validation-link nil)
;; Make htmlize output css-classes (insted of inline)
;; To make it possible to style in CSS
(setq org-html-htmlize-output-type 'css)
;; Define the publishing project
(setq org-publish-project-alist
      '(
        ("nozense-notes"
         :base-directory "~/org/nozen.se"
         :base-extension "org"
         :publishing-directory "/var/www/nozen.se/"
         :recursive t
         :html-toplevel-hlevel 1
         :with-toc t
         :with-title t
         :with-creator t
         :section-numbers nil
         :with-email t
         :auto-sitemap t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :htmlized-source t
         :auto-preamble t
         )
        ("nozense-static"
         :base-directory "~/org/nozen.se"
         :base-extension "css\\|png\\|woff\\|woff2"
         :publishing-directory "/var/www/nozen.se/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("nozense" :components ("nozense-notes" "nozense-static"))
        ))

;;;;;;;;;
;;     ;;
;; END ;;
;;     ;;
;;;;;;;;;
