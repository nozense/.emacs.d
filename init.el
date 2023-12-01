;;;;;;;;;;;;;;;;;;;;;
;; nozense init.el ;;
;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;
;; Load-path's ;;
;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/elisp/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(setq
 user-full-name "NoZenSe"
 user-mail-address "nonsens@nozen.se")


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

;; My own scripts - MOVE!?!
(load "myElisp")
(global-set-key
 (kbd "C-c j")
 (lambda () (interactive)
   (one_file_journal)
   (org-narrow-to-element)))



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
  ;; Make a cusom agenda for non-schedueled todos
  (setq org-agenda-custom-commands
	'(("c" . "Custom Agendas")
          ("cu" "Unscheduled TODO"
           ((todo ""
                  ((org-agenda-overriding-header "\nUnscheduled TODO")
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
           nil
           nil)))
  (setq org-startup-indented nil)
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


;; ORG-captures - MOVE?!


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



;; SETTINGS for org-static-blog
(load "org-static-blog")
(setq org-static-blog-publish-title "nozen.se/blog")
(setq org-static-blog-langcode "sv")
(setq org-static-blog-publish-url "https://nozen.se/blog/")
(setq org-static-blog-publish-directory "/var/www/nozen.se/blog/")
(setq org-static-blog-posts-directory "~/org/blog/posts/")
(setq org-static-blog-drafts-directory "~/org/blog/drafts/")
(setq org-static-blog-enable-tags t)
(setq org-export-with-toc nil)
(setq org-export-with-section-numbers nil)

;; This header is inserted into the <head> section of every page:
;;   (you will need to create the style sheet at
;;    ~/projects/blog/static/style.css
;;    and the favicon at
;;    ~/projects/blog/static/favicon.ico)
(setq org-static-blog-page-header
      "<meta name=\"author\" content=\"nozense\">
      <meta name=\"referrer\" content=\"no-referrer\">
      <meta name=\"viewport\" content=\"initial-scale=1,width=device-width,minimum-scale=1\">
      <link href= \"static/style.css\" rel=\"stylesheet\" type=\"text/css\" />
      <link rel=\"icon\" href=\"static/favicon.ico\">")

;; This preamble is inserted at the beginning of the <body> of every page:
;;   This particular HTML creates a <div> with a simple linked headline
(setq org-static-blog-page-preamble
      "<div class=\"header\"> </div>")

;; This postamble is inserted at the end of the <body> of every page:
;;   This particular HTML creates a <div> with a link to the archive page
;;   and a licensing stub.
(setq org-static-blog-page-postamble
      "<a href=\"https://nozen.se\">nozen.se</a><br />Author: nozense <br />Email: nonsens@nozen.se <br />
  ")

;; This HTML code is inserted into the index page between the preamble and
;;   the blog posts
(setq org-static-blog-index-front-matter
      "<h1>nozen.se/blog </h1>\n")

;; KEYBINDINGS!
(add-to-list 'auto-mode-alist (cons (concat org-static-blog-posts-directory ".*\\.org\\'") 'org-static-blog-mode))
;;    C-c C-f / C-c C-b to open next/previous post.
;;    C-c C-p to open the matching published HTML file of a post.
;;    C-c C-n to create a new blog post.

;; publish SETTINGS for NOZEN.SE
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
         :headline-levels 6
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


;;;;;;;;;;;;;
;;;; END ;;;;
;;;;;;;;;;;;;
