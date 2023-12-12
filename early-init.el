
;;Make a directory for temp/local files - Mostly for no-littering!
 (setq myTmpDir (concat "~/" ".tmpEmacsFiles/"))
 (unless (file-exists-p myTmpDir)
    (make-directory myTmpDir t))

