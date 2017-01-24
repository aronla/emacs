; list the packages you want
(setq package-list '(workgroups2 undo-tree anaconda-mode smart-mode-line smart-mode-line-powerline-theme smex browse-kill-ring anaconda-mode company-anaconda company pyvenv auto-complete ))

; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)
; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq auto-save-file-name-transforms
          `((".*" "/Users/aron/Documents/auto-save/" t))) 


(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(package-initialize)

(add-hook 'ibuffer-mode-hook
	  '(lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "yaml")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default)))
 '(ibuffer-saved-filter-groups (quote (("curentsetup" ("yaml" (used-mode . yaml-mode))))))
 '(ibuffer-saved-filters
   (quote
    (("gnus"
      ((or
	(mode . message-mode)
	(mode . mail-mode)
	(mode . gnus-group-mode)
	(mode . gnus-summary-mode)
	(mode . gnus-article-mode))))
     ("programming"
      ((or
	(mode . emacs-lisp-mode)
	(mode . cperl-mode)
	(mode . c-mode)
	(mode . java-mode)
	(mode . idl-mode)
	(mode . lisp-mode)))))))
 '(package-selected-packages
   (quote
    (smex ido-completing-read+ ido-ubiquitous virtualenvwrapper virtualenv jedi ess elpy ein))))
;; (
 ;;custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;)

(setq inferior-R-program-name "/usr/local/bin/R")
(require 'ess-site)
(setq ess-use-auto-complete 'script-only)
(require 'transpose-frame)
(require 'workgroups2)
;(cua-mode 1)

(setq ns-pop-up-frames nil) ; to open in same emacs fram in OS X
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode 1)
(windmove-default-keybindings 'meta)

(delete-selection-mode 1)
(transient-mark-mode 1)
(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

(global-set-key (kbd "M-x") 'smex)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(setq sml/theme 'powerline) ;smart-mode-line
(sml/setup)

(require 'undo-tree) 
(global-undo-tree-mode)

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)

(setq ibuffer-default-sorting-mode 'major-mode)


(when (fboundp 'winner-mode)
      (winner-mode 1))

(setq ess-eval-visibly-p nil)
(ess-toggle-underscore nil)



(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line


(global-set-key (kbd "C-x C-g") 'find-file-at-point)

(global-set-key [home] 'move-beginning-of-line)
(global-set-key [end] 'move-end-of-line)


;(setq ipython-command "C:\Users\sc_arola\AppData\local\Continuum\Anaconda2\Scripts\ipython") ; discard this line Ipython is already in your PATH
;(require 'ipython)

(eval-after-load "company"
 '(progn
    (add-to-list 'company-backends 'company-anaconda)))
(add-hook 'after-init-hook 'global-company-mode)

(require 'python)

(setq python-shell-interpreter "/usr/local/bin/python3"
      python-shell-interpreter-args "-m IPython --simple-prompt -i")

;(elpy-enable)
;(elpy-use-ipython)
;; (setq python-shell-interpreter "/home/edwold/anaconda2/bin/ipython")
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)

(defun my-python-mode-hook () 
  (linum-mode 1)) 
(add-hook 'python-mode-hook 'my-python-mode-hook) 
;(setq jedi:server-args '("--virtual-env" "C:\Users\sc_arola\AppData\Local\Continuum\Anaconda2\Lib\site-packages"))

;(setq python-shell-interpreter "C:\Users\sc_arola\AppData\local\Continuum\Anaconda2\python.exe" python-shell-interpreter-args "-i C:\Users\sc_arola\AppData\local\Continuum\Anaconda2\Scripts\ipython-script.py")

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t) 

;; (setq jedi:server-args
;;       '("--sys-path" "~/anaconda2/pkgs/" ))

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(auto-complete-mode)
(setq ess-use-auto-complete t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; ARON DEFINED FUNCTIONS

(defun kill-whitespace ()
          "Kill the whitespace between two non-whitespace characters"
          (interactive "*")
          (save-excursion
            (save-restriction
              (save-match-data
		(if (looking-at "[ \t\n]")
                (progn
		  (re-search-forward "[ \t\r\n]+" nil t)
                  (replace-match "" nil nil))
		(
		  kill-word 1)
		)))))

(global-set-key [C-delete] 'kill-whitespace)


(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-beginning-position 2)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position) (line-beginning-position 2)))))



;;; JSON
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -mjson.tool" (current-buffer) t)))


; (setq wg-prefix-key (kbd "C-c z"))
(workgroups-mode 1)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)
