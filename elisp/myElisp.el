
(defun one_file_journal ()
  (setq target_file "~/org/journals/journal.org")
  (setq year (format-time-string "%Y"))
  (setq month (format-time-string "%B"))
  (find-file target_file)
  (unless (ignore-errors
  	    (org-find-exact-headline-in-buffer year))
    (goto-char (point-min))
    (org-insert-heading nil nil t)
    (insert year))
  (goto-char (org-find-exact-headline-in-buffer year))
  (unless (ignore-errors (org-find-exact-headline-in-buffer month))
    (goto-char (org-find-exact-headline-in-buffer year))
    (end-of-line)
    (org-insert-subheading t)
    (insert month)
    )
  (goto-char (org-find-exact-headline-in-buffer month)))


(defun myCreateBlogFileWithDate ()
  (let ((name (read-string "Name: ")))
    (expand-file-name (format "%s-%s.org"
                              (format-time-string "%Y-%m-%d")
                              name) "~/org/blog/posts/")))

