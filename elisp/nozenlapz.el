;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Machine specific settings for laptop - nozenlapz ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;
;; Dracula pro theme ;;
;;;;;;;;;;;;;;;;;;;;;;;

 (add-to-list 'custom-theme-load-path "~/org/draculaPRO/themes/emacs/")
   (load-theme 'dracula-pro-blade t)

;; Pyhton
;; pip install python-language-server[all]


(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         (python-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;;;;;;;;;;;;;;;;;;;
;;               ;;
;; SLIME - cLisp ;;
;;               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Using: (https://lisp-lang.org/learn/getting-started/) ;;
;; SBCL                                                  ;;
;; Quicklisp                                             ;;
;; and SLIME                                             ;;
;;                                                       ;;
;; run slime before using (=                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load (expand-file-name "~/.quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")


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
         "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+1d\"))\n %i")))

;;;;;;;;;
;;     ;;
;; END ;;
;;     ;;
;;;;;;;;;
