;;; init.el --- The first thing GNU Emacs runs

;; Do NOT run garbage collection during startup.
;; This drastically improves `emacs-init-time'.
(setq gc-cons-threshold 999999999)

;; Ignore REGEXP checks of file names at startup.
;; This also drastically improves `emacs-init-time'.
;; NOTE: Some bogus, benign errors will be thrown.
(let ((file-name-handler-alist nil))

  ;; Set up package.el for use with MELPA
  (require 'package)
  (setq package-enable-at-startup nil)
  (add-to-list 'package-archives
               '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)

  ;; Bootstrap use-package.  It will manage all other packages.
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

  ;; Reduce load time of use-package
  (eval-when-compile
    (require 'use-package))

  (require 'diminish) ; allows for easy removal of packages' modeline strings
  (require 'bind-key) ; simplifies how keybindings are set

  ;; Tangle & load the rest of the config!
  (org-babel-load-file "~/.emacs.d/geoff.org"))

;; Revert garbage collection behavior
(run-with-idle-timer
 5 nil
 (lambda ()
   (setq gc-cons-threshold 2000000)))

;;; init.el ends here
