;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     nozense init.el                             ;;
;;                     ;;;;;;;;;;;;;;;                             ;;
;; This file contains settings i want on all my machines!          ;;
;; Check elisp/default.el to se how i load machine specific files. ;;
;; All my settings are included, check elisp/, as inspiration.     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;
;; Load-path's ;;
;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/elisp/")

(setq
 user-full-name "NoZenSe"
 user-mail-address "nonsens@nozen.se")

;; Move the set-custom to a separate file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Some random settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set utf-8 language coding
(set-language-environment "UTF-8")
;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
;; Enable transient mark mode
(transient-mark-mode 1)
;; Mouse support for xterm compatible terminals
(xterm-mouse-mode t)
;; This makes it so that emacs tries to indent to the correct lvl, if
;; that is not possible (allready correct) it tries to auto-complete with TAB
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)
;; Keybind for visiual-line-mode!
(global-set-key (kbd "C-c w") (lambda () (interactive)
				(visual-line-mode 'toggle)))


;;;;;;;;;;;;;;;;;;;;;;
;; We want packages ;;
;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
;; Add packages from MELPA stable - often more up to date than Emacs Elpa
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; Activate the packages!
(package-initialize)
;; Check if we have a list of packages
(unless package-archive-contents
  (package-refresh-contents))
;; Cheese way to ensure all packages are installed, and install those thats not.
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;;
;; use-package ;;
;;;;;;;;;;;;;;;;;

(use-package no-littering
  :init
  (setq no-littering-etc-directory
	(expand-file-name "config/" myTmpDir))
  (setq no-littering-var-directory
	(expand-file-name "data/" myTmpDir)))

;; We NEED org-mode!
(use-package org
  :config
  ;; Don't show Done in agenda
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)
  ;; Log time of completion on TODOs -> DONE
  (setq org-log-done 'time)
  ;; Start org-mode in indented-mode
  (setq org-startup-indented t)
  ;; Hide the leading stars!
  (setq org-hide-leading-stars t)
  ;; Agenda files
  (setq org-agenda-files '("~/org/journals/"))
  ;; Org Keybinds - from the quick-start guide!
  (global-set-key (kbd "C-c l") #'org-store-link)
  (global-set-key (kbd "C-c a") #'org-agenda)
  (global-set-key (kbd "C-c c") #'org-capture)
  (setq org-fontify-whole-heading-line t))

(use-package ido
  :config
  (ido-mode t))
;; Autocomplete kommandon
(use-package which-key
  :config
  (which-key-mode))
;; Vertico autocomplete
(use-package vertico
  :config
  (vertico-mode t))
;; COMPANY-mode "complete anything"
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package dracula-theme
  :config
  (load-theme 'dracula t)
  (setq-default cursor-type 'box))

(use-package avy
  :config
  ;; avy keybinds
  (global-set-key (kbd "M-g e") 'avy-goto-word-0))

(use-package htmlize)
(use-package markdown-mode)
(use-package php-mode)

;;;;;;;;;;;;;
;;;; END ;;;;
;;;;;;;;;;;;;
