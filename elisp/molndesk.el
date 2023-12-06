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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;; SETTINGS for org-static-blog ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
