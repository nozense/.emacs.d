;; -*- mode: elisp -*-

(add-to-list 'load-path "~/.emacs.d/elisp/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(setq
 user-full-name "NoZenSe"
 user-mail-address "nonsens@nozen.se")


;;Make a directory for temp/local files - Mostly for no-littering!
 (setq myTmpDir (concat "~/" ".tmpEmacsFiles/"))
 (unless (file-exists-p myTmpDir)
    (make-directory myTmpDir t))

;; no littering!
(setq no-littering-etc-directory
      (expand-file-name "config/" myTmpDir))
(setq no-littering-var-directory
      (expand-file-name "data/" myTmpDir))
(use-package no-littering)



;; Add packages from MELPA stable - often more up to date than Emacs Elpa
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Set utf-8 language coding
(set-language-environment "UTF-8")
;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
;; Enable transient mark mode
(transient-mark-mode 1)

;; We NEED org-mode!
(require 'org)

;; Don't show Done in agenda
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
;; Log time of completion on TODOs -> DONE
(setq org-log-done 'time)
;; Start org-mode in indented-mode
(setq org-startup-indented nil)



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



;; Load the local copy of org-static-blog
;; (load (expand-file-name "org-static-blog.el" "~/org/settings/"))


;; Whitespace mode
;; Stolen from the Discovering Emacs podcast
;; https://github.com/VernonGrant Discovering Emacs / WhiteSpace mode (github)
;; Works very well for me - and its good to have as a basis for your own changes!
;; Define the whitespace style.
(setq-default whitespace-style
              '(face spaces empty tabs newline trailing space-mark tab-mark newline-mark))
;; Make these characters represent whitespace.
(setq-default whitespace-display-mappings
              '(
                ;; space -> · else .
                (space-mark 32 [183] [46])
                ;; new line -> ¬ else $
                (newline-mark ?\n [172 ?\n] [36 ?\n])
                ;; carriage return (Windows) -> ¶ else #
                (newline-mark ?\r [182] [35])
                ;; tabs -> » else >
                (tab-mark ?\t [187 ?\t] [62 ?\t])))
;; Don't enable whitespace for.
(setq-default whitespace-global-modes
              '(not shell-mode
                    help-mode
                    magit-mode
                    magit-diff-mode
                    ibuffer-mode
                    dired-mode
                    occur-mode))
;;(global-whitespace-mode 1)
;; Set whitespace actions.
(setq-default whitespace-action
              '(cleanup auto-cleanup))


;;;;;;;;;;; Autocompletes!
;; Autocomplete for filelists search and so on
(require 'ido)
;; (setq ido-save-directory-list-file (concat myTmpDir "ido-last"))
(ido-mode t)
;; Autocomplete kommandon
(which-key-mode)
;; Vertico autocomplete
(vertico-mode t)
;; COMPANY-mode "complete anything"
(add-hook 'after-init-hook 'global-company-mode)


;; Mouse support for xterm compatible terminals
(xterm-mouse-mode t)

;; This makes it so that emacs tries to indent to the correct lvl, if
;; that is not possible (allready correct) it tries to auto-complete with TAB
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)


;; Org Keybinds - from the quick-start guide!
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
;; Whitespace mode
;; Little function to actualy activate two modes with one key-bind!
(global-set-key (kbd "C-c w") (lambda () (interactive)
					;(whitespace-mode 'toggle)
				(visual-line-mode 'toggle)))


;; Make a cusom agenda for non-schedueled todos
(setq org-agenda-custom-commands
      '(("c" . "Custom Agendas")
        ("cu" "Unscheduled TODO"
         ((todo ""
                ((org-agenda-overriding-header "\nUnscheduled TODO")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
         nil
         nil)))


;; avy keybinds
(global-set-key (kbd "M-g e") 'avy-goto-word-0)


(load "myElisp")
(global-set-key
 (kbd "C-c j")
 (lambda () (interactive)
   (one_file_journal)
   (org-narrow-to-element)))





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





;;(load-theme 'leuven t)
(load-theme 'dracula t)
(setq org-fontify-whole-heading-line t)
(setq-default cursor-type 'box)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961" "34af44a659b79c9f92db13ac7776b875a8d7e1773448a8301f97c18437a822b6" "80b00f3bf7cdbdca6c80aadfbbb03145f3d0aacf6bf2a559301e61109954e30a" "b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" "3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" "19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" "f366d4bc6d14dcac2963d45df51956b2409a15b770ec2f6d730e73ce0ca5c8a7" "5dcd1fb4603626df9eaec6583e159cf0de1d86facb8c2814e6d9ffab0cac8396" default))
 '(org-agenda-files
   '("~/org/journals/todo.org" "/home/nozense/org/journals/journal.org" "/home/nozense/org/cheat-sheet.org" "/home/nozense/org/data/aeran.org" "/home/nozense/org/data/data.org" "/home/nozense/org/data/datta.org" "/home/nozense/org/data/linn.org"))
 '(package-selected-packages
   '(dracula-theme no-littering php-mode avy company vertico htmlize which-key markdown-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
