;; File: init.el
;; Description: To be a config file to customize Emacs with a heavy emphasis on org-mode and journaling
;; Package list: in README

;; loads the emacs package management system (built in as of emacs 29 iirc)
(require 'package)
;; melpa is the most popular package repository for emacs packages
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; loads all the installed packages
(package-initialize)
;; There's also MELPA Stable but generally not needed since it's behind in releases for most packages and most packages are “stable” anyway
;; (add-to-list 'package-archives '("melpa" . "https://stable.melpa.org/packages/") t)

;; first package we'll install will help us use the minibuffer easier
;; very useful to me as I learn the ins and outs of emacs
(use-package vertico
  :ensure t
  ;; ensure vertico-mode always loads to enable completion in the minibuffer
  :init
  (vertico-mode))

;; make sure vertico remembers our used commands across restarts
(use-package savehist
  :init
  (savehist-mode))

;; continuing with the theme of helping us learn emacs, we'll install an annotator
;; for all the commands in the mini buffer
(use-package marginalia
  ;; to cycle between more and less detailed annotations, we add binding “M-A”
  :bind (:map minibuffer-local-map
	      ("M-A" . marginalia-cycle))
  ;; ensure marginalia-mode always loads to enable annotations
  :init
  (marginalia-mode))

;; I like my IDEs to have line numbers for easier navigation
(global-display-line-numbers-mode t)

;; of course, we also want a completion system. i like company but others work as well
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  ;; the following adjust when you want to completion system to kick in and if you
  ;; want a delay
  :config
  (setq company-minimum-prefix-length 1
	company-idle-delay 0.0))

;; I work with a fair bit of .mdx files which does not have any built-in support for
;; syntax highlighting, so let's fix that
(use-package markdown-mode
  :ensure t
  :mode ("\\.mdx\\'" . markdown-mode))

;; Let's also set up org mode, one of the biggest reasons why I use emacs
(use-package org
  :ensure t
  :bind (("C-c a" . org-agenda)
	 ("C-c c" . org-capture))
  :config
  ;; this is the default value for org-directory but you can change it if you wish
  (setq org-directory "~/org")
  ;; disables confirmation before executing code
  (setq org-confirm-babel-evaluate nil)
  ;; sets the default file that stores org-capture notes
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  ;; tells emacs to look here for org-agenda files
  (setq org-files '("~/org/"))
  ;; enables native syntax
  (setq org-src-fontify-natively t))

;; let's also adjust the startup process to show the agenda on startup
(defun open-agenda-split ()
  "Opens org-agenda and all todo items on left and another buffer on the right on startup."
  (org-agenda nil "n")
  (delete-other-windows)
  (split-window-right)
  (other-window 1)
  (switch-to-buffer "*GNU Emacs*")
  (other-window 1))
(add-hook 'emacs-startup-hook #'open-agenda-split)

;; I also like to journal and there's a neat little package that makes it easy
(use-package org-journal
  :ensure t
  :defer t
  :init
  ;; you can change the default prefix key if you desire,
  (setq org-journal-prefix-key "C-c j ")
  :config
  (setq org-journal-dir "~/org/journal"
	org-journal-file-format "%Y-%m-%d.org"
	org-journal-date-format "%A, %d %B %Y"
	org-journal-file-type 'daily) ;; each file will represent a daily entry
  ;; enables integration with org-agenda for entries in the future
  (setq org-journal-enable-agenda-integration t)
  ;; we'll create a custom header for each daily entry as well
  (defun org-journal-file-header-func (time)
    "Custom function to create journal header."
    (concat
     (pcase org-journal-file-type
       (`daily (concat "#+TITLE: Journal Entry - %Y-%m-%d\n"
                       "#+STARTUP: showeverything\n\n"
                       "* Morning Routine\n"
                       " - [ ] Wake up at 9:30am\n"
                       " - [ ] Brush Teeth\n"
                       " - [ ] Shower and Shave\n"
                       " - [ ] Clean room and make bed\n\n"
                       "* Learning and Development\n"
                       " - [ ] Teach yourself CS (3 hours)\n"
                       " - [ ] Apply to at least one job\n"
                       " - [ ] Work on one side project or a blog post\n\n"
                       "* Health and Fitness\n"
                       " - [ ] Daily Run\n\n"
                       "* Night Routine\n"
                       " - [ ] Brush Teeth\n"
                       " - [ ] Write down two things you want to get done the next day\n"
                       " - [ ] Finish journal for the day before you go to bed\n\n"))
       (`weekly "#+TITLE: Weekly Journal\n#+STARTUP: folded\n")
       (`monthly "#+TITLE: Monthly Journal\n#+STARTUP: folded\n")
       (`yearly "#+TITLE: Yearly Journal\n#+STARTUP: folded\n"))))
  (setq org-journal-file-header 'org-journal-file-header-func))

;; Non-intel macbooks don't have native support for Scheme so Racket must be used to evaluate
;; (non-emacs) lisp code. Since I do work with lisp somewhat, I'll be installing it below:
(use-package racket-mode
  :ensure t
  :mode "\\.rkt\\'"
  :config
  (add-hook 'racket-mode-hook #'racket-xp-mode))

;; always start emacs fully maximized (note this doesn't mean any frames created after startup will be fully maximized)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; I don't like backup files being in the same directory of the file I'm working on so I made
;; a special directory for emacs to store them
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t) ;; copies files for backup rather than renaming them

;; no changes need to be saved

;; below is automatically generated by use-package
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("/Users/anmol/org/notes.org" "/Users/anmol/org/workflow.org" "/Users/anmol/org/journal/2023-12-13.org"))
 '(package-selected-packages
   '(racket-mode org-journal markdown-mode company marginalia vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
