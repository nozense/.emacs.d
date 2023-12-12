
;;Make a directory for temp/local files - Mostly for no-littering!
 (setq myTmpDir (concat "~/" ".tmpEmacsFiles/"))
 (unless (file-exists-p myTmpDir)
    (make-directory myTmpDir t))


;; Put eln-cache dir in cache directory
;; NOTE the method for setting the eln-cache dir depends on the emacs version
;; https://github.com/SystemCrafters/crafted-emacs/issues/103
(when (fboundp 'startup-redirect-eln-cache)
  (if (< emacs-version 29)
      (add-to-list 'native-comp-eln-load-path (concat myTmpDir "eln-cache/"))
    (startup-redirect-eln-cache (concat myTmpDir "eln-cache/"))))
