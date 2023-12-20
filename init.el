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
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)


;; The default is 800 kilobytes.  Measured in bytes. <- Systemcrafters idea! (=
(setq gc-cons-threshold (* 50 1000 1000))

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
;; Nice symbol for visiual-line-mode
(setq visual-line-fringe-indicators '(nil right-curly-arrow))
;; Keybind for visiual-line-mode!
(global-set-key (kbd "C-c w") (lambda () (interactive)
				(visual-line-mode 'toggle)))
;; Keybind for speedbar
(global-set-key (kbd "C-c b") (lambda () (interactive) (speedbar)))
;; Tab bar mode!
(add-to-list 'tab-bar-format #'tab-bar-format-menu-bar)
(setq tab-bar-close-button-show nil
      tab-bar-new-button-show nil)
(tab-bar-mode t)
;; no need for tool-bars
(tool-bar-mode -1)
;; no need for menus
(menu-bar-mode -1)
;; no scrollbar - plz!
(scroll-bar-mode -1)
;; save place mode
(save-place-mode 1)
;; Line numbers
(global-display-line-numbers-mode)
;; Highlight current line
(global-hl-line-mode)

;;;;;;;;;;;;;;;;;;;;;;
;; We want packages ;;
;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;;
;; use-package ;;
;;;;;;;;;;;;;;;;;

(use-package no-littering
  :init
  (setq no-littering-etc-directory
	(expand-file-name "config/" myTmpDir))
  (setq no-littering-var-directory
	(expand-file-name "data/" myTmpDir))
  (setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (setq backup-directory-alist
	`((".*" . ,myTmpDir)))
  (setq auto-save-file-name-transforms
	`((".*" ,myTmpDir t))))

;; Keep packages up-to-date!
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))


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
  ;; agenda setup
  (setq org-agenda-window-setup 'reorganize-frame)
  (setq org-agenda-restore-windows-after-quit t)
  ;; Hide the leading stars!
  (setq org-hide-leading-stars t)
  ;; Agenda files
  (setq org-agenda-files '("~/org/journals/"))
  ;; Org Keybinds - from the quick-start guide!
  (global-set-key (kbd "C-c l") #'org-store-link)
  (global-set-key (kbd "C-c a") #'org-agenda)
  (global-set-key (kbd "C-c c") #'org-capture)
  (setq org-fontify-whole-heading-line t))

(use-package org-modern
  :config
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))
;; Autocomplete kommandon
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))
;; Color nested stuff
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;; Auto-complete and such! ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vertico, Marginalia, Consult, Embark, Orderless ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vertico - Vertical completion in mini-buffer
;; Marginalia - More information in the margin of minibuffer
;; Consult - Search and navigation from list of candidates
;; Oderless - Makes the list-candidates searchable in more ways
;; Embark - Context aware "command to run"
;; https://cestlaz.github.io/post/using-emacs-80-vertico/

(load "init-VMCEO") ;; <-- elisp/init-VMCEO.el

;; COMPANY-mode in-buffer completion!
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package dracula-theme
  :config
  (load-theme 'dracula t)
  (setq-default cursor-type 'box))

(use-package avy
  :bind (("M-g e" . avy-goto-word-0)
  ("M-g C-e" . avy-goto-word-0)
  ("M-g w" . avy-goto-word-1)
  ("M-g f" . avy-goto-line)
  ("C-'" . avy-goto-char-2)
  ("C-:" . avy-goto-char)))

(use-package wc-mode)
(use-package s)
(use-package htmlize)
(use-package markdown-mode
  :mode "\\.md\\'")
(use-package php-mode
  :mode "\\.php\\'")
(use-package nov
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  :mode "\\.epub\\'")

(use-package god-mode
  :bind (("<escape>" . god-local-mode))
  :config
  (setq god-exempt-major-modes nil)
  (setq god-exempt-predicates nil)
  (global-set-key (kbd "C-c g") #'god-local-mode) ;; For mobile use - esc dosent work!
  (global-set-key (kbd "C-x C-1") #'delete-other-windows)
  (global-set-key (kbd "C-x C-2") #'split-window-below)
  (global-set-key (kbd "C-x C-3") #'split-window-right)
  (global-set-key (kbd "C-x C-0") #'delete-window)
  (define-key god-local-mode-map (kbd "[") #'backward-paragraph)
  (define-key god-local-mode-map (kbd "]") #'forward-paragraph)
  (define-key god-local-mode-map (kbd "z") #'repeat)
  (define-key god-local-mode-map (kbd "i") #'god-local-mode)
  (custom-set-faces
   '(god-mode-lighter ((t (:inherit error)))))
  (defun my-god-mode-update-cursor-type ()
    (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))
  (add-hook 'post-command-hook #'my-god-mode-update-cursor-type))

;;;;;;;;;;;
;; OTHER ;;
;;;;;;;;;;;


;; stolen https://systemcrafters.net/emacs-from-scratch/cut-start-up-time-in-half/

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                   (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)


;; Make gc pauses faster by decreasing the threshold. <- Systemcrafters idea (=
(setq gc-cons-threshold (* 2 1000 1000))

;;;;;;;;;;;;;
;;;; END ;;;;
;;;;;;;;;;;;;
