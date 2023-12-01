;; Check the name of the machine and load machine-specific settings

(if (string= (system-name)
	     "nozenlapz-UX430UAR")
    (load "nozenlapz") nil)

(if (string= (system-name)
	     "molndesk")
    (load "molndesk") nil)
