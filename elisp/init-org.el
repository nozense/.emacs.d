
;; We NEED org-mode!
(use-package org
  :config
  ;; Don't show Done in agenda
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)
  ;; Log time of completion on TODOs -> DONE
  (setq org-log-done 'time)
  ;; Start org-mode in indented-mode
  (setq org-startup-indented t)
  ;; agenda setup
  (setq org-agenda-window-setup 'reorganize-frame)
  (setq org-agenda-restore-windows-after-quit t)
  ;; Hide the leading stars!
  (setq org-hide-leading-stars t)
  ;; Agenda files
  (setq org-agenda-files '("~/org/journals/"))
  ;; Org Keybinds - from the quick-start guide!
  (global-set-key (kbd "C-c l") #'org-store-link)
  (global-set-key (kbd "C-c a") #'org-agenda)
  (global-set-key (kbd "C-c c") #'org-capture)
  (setq org-fontify-whole-heading-line t))

(use-package org-modern
  :config
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))
