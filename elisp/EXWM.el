
;;  Adopted from [[https://github.com/daviwil/emacs-from-scratch/][System Crafters]]


(defun efs/run-in-background (command)
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

(defun efs/exwm-init-hook ()
  ;; Make workspace 1 be the one where we land at startup
  (exwm-workspace-switch-create 1)
  
  ;; Open eshell by default
  (eshell)
  
  ;; NOTE: The next two are disabled because we now use Polybar!
  
  ;; Show battery status in the mode line
  (display-battery-mode 1)
  
    ;; Show the time and date in modeline
  (setq display-time-day-and-date t)
  (display-time-mode 1)
  ;; Also take a look at display-time-format and format-time-string
  
  ;; Start the Polybar panel
  ;; (efs/start-panel)
  
  ;; Launch apps that will run in the background
  ;; (efs/run-in-background "dunst")
  ;;(efs/run-in-background "nm-applet")
  (efs/run-in-background "pasystray")
  (efs/run-in-background "blueman-applet"))

  (defun efs/exwm-update-class ()
    (exwm-workspace-rename-buffer exwm-class-name))

(defun efs/exwm-update-title ()
  (pcase exwm-class-name
    ("Firefox" (exwm-workspace-rename-buffer (format "Firefox: %s" exwm-title)))))


;; This function should be used only after configuring autorandr!
  (defun efs/update-displays ()
    (efs/run-in-background "autorandr --change --force")
    (message "Display config: %s"
             (string-trim (shell-command-to-string "autorandr --current"))))

(use-package exwm
  :config
  ;; Set the default number of workspaces
  (setq exwm-workspace-number 5)
  
    ;; When window "class" updates, use it to set the buffer name
  (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)
  
  ;; When window title updates, use it to set the buffer name
  (add-hook 'exwm-update-title-hook #'efs/exwm-update-title)
  

  ;; When EXWM starts up, do some extra confifuration
  (add-hook 'exwm-init-hook #'efs/exwm-init-hook)
  
  ;; Rebind CapsLock to Ctrl
  (start-process-shell-command "xmodmap" nil "xmodmap ~/.emacs.d/exwm/Xmodmap")
  
  ;; NOTE: Uncomment the following two options if you want window buffers
  ;;       to be available on all workspaces!
  
    ;; Automatically move EXWM buffer to current workspace when selected
  ;; (setq exwm-layout-show-all-buffers t)
  
  ;; Display all EXWM buffers in every workspace buffer list
  ;; (setq exwm-workspace-show-all-buffers t)
  
  ;; NOTE: Uncomment this option if you want to detach the minibuffer!
  ;; Detach the minibuffer (show it with exwm-workspace-toggle-minibuffer)
  ;;(setq exwm-workspace-minibuffer-position 'top)
  
  ;; Set the screen resolution (update this to be the correct resolution for your screen!)
  (require 'exwm-randr)
  (exwm-randr-enable)
  (start-process-shell-command "xrandr" nil "xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal")
  
  
  ;; NOTE: Uncomment these lines after setting up autorandr!
  ;; React to display connectivity changes, do initial display update
  ;; (add-hook 'exwm-randr-screen-change-hook #'efs/update-displays)
  ;; (efs/update-displays)
  
  ;; NOTE: This is disabled because we now use Polybar!
  ;; Load the system tray before exwm-init
  ;; (require 'exwm-systemtray)
  ;; (setq exwm-systemtray-height 32)
  ;; (exwm-systemtray-enable)
  
  ;; Automatically send the mouse cursor to the selected workspace's display
  (setq exwm-workspace-warp-cursor t)
  
  ;; Window focus should follow the mouse pointer
    (setq mouse-autoselect-window t
          focus-follows-mouse t)
    
    ;; These keys should always pass through to Emacs
    (setq exwm-input-prefix-keys
	  '(?\C-x
            ?\C-u
            ?\C-h
            ?\M-x
            ?\M-`
            ?\M-&
            ?\M-:
            ?\C-\M-j  ;; Buffer list
            ?\C-\ ))  ;; Ctrl+Space
    
    ;; Ctrl+Q will enable the next key to be sent directly
    (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
    
    ;; Set up global key bindings.  These always work, no matter the input state!
    ;; Keep in mind that changing this list after EXWM initializes has no effect.
    (setq exwm-input-global-keys
          `(
            ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
            ([?\s-r] . exwm-reset)
	    
            ;; Move between windows
            ([s-left] . windmove-left)
            ([s-right] . windmove-right)
            ([s-up] . windmove-up)
            ([s-down] . windmove-down)
	    
            ;; Launch applications via shell command
            ([?\s-&] . (lambda (command)
                         (interactive (list (read-shell-command "$ ")))
                         (start-process-shell-command command nil command)))
	    
            ;; Switch workspace
            ([?\s-w] . exwm-workspace-switch)
            ([?\s-`] . (lambda () (interactive) (exwm-workspace-switch-create 0)))

            ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
            ,@(mapcar (lambda (i)
                        `(,(kbd (format "s-%d" i)) .
                          (lambda ()
                            (interactive)
                            (exwm-workspace-switch-create ,i))))
                      (number-sequence 0 9))))
    
    (exwm-input-set-key (kbd "s-SPC") 'counsel-linux-app)
    
    (exwm-enable))

(use-package desktop-environment
  :after exwm
  :config (desktop-environment-mode)
  :custom
  (desktop-environment-brightness-small-increment "2%+")
  (desktop-environment-brightness-small-decrement "2%-")
  (desktop-environment-brightness-normal-increment "5%+")
  (desktop-environment-brightness-normal-decrement "5%-"))


