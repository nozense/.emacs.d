
;;Make a directory for temp/local files - Mostly for no-littering!
 (setq myTmpDir (concat "~/" ".tmpEmacsFiles/"))
 (unless (file-exists-p myTmpDir)
    (make-directory myTmpDir t))

(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "var/eln-cache/" myTmpDir))))

