;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; INSTALL PACKAGES
; list the packages you want
(setq package-list '(workgroups2 undo-tree anaconda-mode smart-mode-line smart-mode-line-powerline-theme smex browse-kill-ring anaconda-mode company-anaconda company pyvenv auto-complete transpose-frame evil key-chord))
; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
; activate all the packages (in particular autoloads)
(package-initialize)
; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))
; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; AUTO-SAVE FILE
(setq auto-save-file-name-transforms
          `((".*" "/Users/aron/Documents/auto-save/" t))) 

;; MAC SPECIFIC
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(setq ns-pop-up-frames nil) ; to open in same emacs fram in OS X

;; EVIL MODE
(require 'evil)
(evil-mode 1)

;Exit insert mode by pressing j and then j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

;; AUTO COMPLETE
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(auto-complete-mode)

;; IBUFFER
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

;; R-SPECIFIC
(setq inferior-R-program-name "/usr/local/bin/R")
(require 'ess-site)
(setq ess-use-auto-complete 'script-only)
(require 'transpose-frame)
(require 'workgroups2)
(setq ess-use-auto-complete t)

;; GENERAL CONFIG
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
(workgroups-mode 1)
(custom-set-faces)
(put 'dired-find-alternate-file 'disabled nil)
;(cua-mode 1)

;; UNDO TREE
(require 'undo-tree) 
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
(setq undo-tree-visualizer-timestamps t) 

;; IBUFFER
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
(setq ibuffer-default-sorting-mode 'major-mode)

;; WINNER MODE
(when (fboundp 'winner-mode)
      (winner-mode 1))

;; KEY CONFIGS
(global-set-key (kbd "C-x C-g") 'find-file-at-point)
(global-set-key [home] 'move-beginning-of-line)
(global-set-key [end] 'move-end-of-line)

;; PYTHON SPECIFIC
;(setq ipython-command "C:\Users\sc_arola\AppData\local\Continuum\Anaconda2\Scripts\ipython") ; discard this line Ipython is already in your PATH
;(require 'ipython)
(require 'python)
(eval-after-load "company"
 '(progn
    (add-to-list 'company-backends 'company-anaconda)))
(add-hook 'after-init-hook 'global-company-mode)
(setq python-shell-interpreter "/usr/local/bin/python3"
      python-shell-interpreter-args "-m IPython --simple-prompt -i")
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
(defun my-python-mode-hook () 
  (linum-mode 1)) 
(add-hook 'python-mode-hook 'my-python-mode-hook) 
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t) 
;; (setq jedi:server-args
;;       '("--sys-path" "~/anaconda2/pkgs/" ))

;; JSON
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -mjson.tool" (current-buffer) t)))

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
; list the repositories containing them
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





