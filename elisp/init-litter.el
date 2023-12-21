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
