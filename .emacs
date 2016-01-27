(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(inferior-R-program-name "c:\\Program Files\\R\\R-3.2.2\\bin\\x64\\Rterm.exe")
 '(package-selected-packages
   (quote
    (smex ido-completing-read+ ido-ubiquitous virtualenvwrapper virtualenv jedi ess elpy ein))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'ess-site)
(setq ess-use-auto-complete 'script-only)

(cua-mode 1)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(windmove-default-keybindings 'meta)

(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

(global-set-key (kbd "M-x") 'smex)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

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



;(setq ipython-command "C:\Users\sc_arola\AppData\local\Continuum\Anaconda2\Scripts\ipython") ; discard this line Ipython is already in your PATH
;(require 'ipython)

(require 'python)
(elpy-enable)
(elpy-use-ipython)

;(setq jedi:server-args '("--virtual-env" "C:\Users\sc_arola\AppData\Local\Continuum\Anaconda2\Lib\site-packages"))

;(setq python-shell-interpreter "C:\Users\sc_arola\AppData\local\Continuum\Anaconda2\python.exe" python-shell-interpreter-args "-i C:\Users\sc_arola\AppData\local\Continuum\Anaconda2\Scripts\ipython-script.py")

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t) 


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



;;; JSON
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -mjson.tool" (current-buffer) t)))
