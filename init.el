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


(setq inhibit-splash-screen t)         ;; Disable the splash screen
(setq inhibit-startup-message t)       ;; Disable startupmessage
(set-language-environment "UTF-8")     ;; Set utf-8 language coding
(tool-bar-mode -1)                     ;; no need for tool-bars
(menu-bar-mode -1)                     ;; no need for menus
(scroll-bar-mode -1)                   ;; no scrollbar - plz!
(save-place-mode 1)                    ;; save place mode
(global-display-line-numbers-mode)     ;; Line numbers
(global-hl-line-mode)                  ;; Highlight current line
(transient-mark-mode 1)                ;; Enable transient mark mode
(xterm-mouse-mode t)                   ;; Mouse support for xterm compatible terminals



;; Keybinds

(setq visual-line-fringe-indicators    ;; Nice symbol for visiual-line-mode
      '(nil right-curly-arrow))
(global-set-key (kbd "C-c w")          ;; Keybind for visiual-line-mode!
		(lambda ()
		  (interactive)
		  (visual-line-mode 'toggle)))
(global-set-key (kbd "C-c b")          ;; Keybind for speedbar
		(lambda ()
		  (interactive)
		  (speedbar)))

;;;;;;;;;;;;;;;;;
;; use-package ;;
;;;;;;;;;;;;;;;;;

(load "init-packages")
(load "init-litter")
(load "init-org")
(load "init-god")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;; Auto-complete and such! ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

;; COMPANY-mode in-buffer completion!
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))


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

;; Moody mode-bar!
(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode)
  (moody-replace-eldoc-minibuffer-message-function))

;; Color nested stuff
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Hide minor-modes in a menu
(use-package minions
  :config (minions-mode 1))

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
