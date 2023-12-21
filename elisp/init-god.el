;; God-mode with some key-binds and stuff
(use-package god-mode
  :bind (("<escape>" . god-local-mode))
  :config
  (setq god-exempt-major-modes nil)
  (setq god-exempt-predicates nil)
  (global-set-key (kbd "C-c g") #'god-local-mode) ;; For mobile use - esc dosent work!
  (global-set-key (kbd "C-x C-1") #'delete-other-windows)
  (global-set-key (kbd "C-x C-2") #'split-window-below)
  (global-set-key (kbd "C-x C-3") #'split-window-right)
  (global-set-key (kbd "C-x C-0") #'delete-window)
  (define-key god-local-mode-map (kbd "[") #'backward-paragraph)
  (define-key god-local-mode-map (kbd "]") #'forward-paragraph)
  (define-key god-local-mode-map (kbd "z") #'repeat)
  (define-key god-local-mode-map (kbd "i") #'god-local-mode)
  (custom-set-faces
   '(god-mode-lighter ((t (:inherit error)))))
  (defun my-god-mode-update-cursor-type ()
    (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))
  (add-hook 'post-command-hook #'my-god-mode-update-cursor-type))
