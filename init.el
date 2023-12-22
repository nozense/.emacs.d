;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     nozense init.el                             ;;
;;                     ;;;;;;;;;;;;;;;                             ;;
;; This file contains settings i want on all my machines!          ;;
;; Check elisp/default.el to se how i load machine specific files. ;;
;; All my settings are included, check elisp/, as inspiration.     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(add-to-list 'load-path "~/.emacs.d/elisp/")

;; Require ORG and load the settings with babel
(require 'org)
(org-babel-load-file
 (expand-file-name "emacs.org"
                   user-emacs-directory))

;;;;;;;;;;;;;
;;;; END ;;;;
;;;;;;;;;;;;;
