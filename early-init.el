
;;Make a directory for temp/local files - Mostly for no-littering!
 (setq myTmpDir (concat "~/" ".tmpEmacsFiles/"))
 (unless (file-exists-p myTmpDir)
    (make-directory myTmpDir t))

;; Set eln-cache dir
(when (boundp 'native-comp-eln-load-path)
  (startup-redirect-eln-cache
   (expand-file-name "/var/eln-cache" myTmpDir)))
