;; -*- mode: elisp -*-

;;;; ForceBackups
;;   -- from https://www.emacswiki.org/emacs/BackupDirectory
(setq
      backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.local/emacs-backups/"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))


;;;; Visual settings 
;; disable menubar, toolbar and scrollbar
(menu-bar-mode   -1)
(tool-bar-mode   -1)
(scroll-bar-mode -1)
;; dont restore frames on startup
(setq desktop-restore-frames nil)
; enable electric minibuffer
(minibuffer-electric-default-mode 1)
; shorten default value hint
(setq minibuffer-eldef-shorten-default t)
; inhibit the splash screen
(setq inhibit-splash-screen t)

; turn line numbers on (Emacs >= 26, for older versions use linum-mode)
(global-display-line-numbers-mode t)
(global-hl-line-mode 1)
(setq display-line-numbers t)


;; this is a very very very very very very very very very very very very very very very long line

;; MODUS THEMES CUSTOMIZATION ;; 
(setq modus-themes-bold-construct t
      modus-themes-italic-constructs t
      modus-themes-subtle-line-numbers t
      modus-themes-box-buttons '(flat accented all-buttons)
      modus-themes-mode-line '(borderless)
      modus-themes-fringes '(intense)
      modus-themes-hl-line '(accented intense)
      modus-themes-paren-match '(bold intense)
      modus-themes-region '(accented no-extend bg-only))
					; load theme
(load-theme 'modus-vivendi)
					; set font
;; Acroding to https://emacs.stackexchange.com/questions/52063/emacsclient-gui-has-small-fonts
;; aparently (set-frame-font "mononoki-13" nil t) don't work

(add-to-list 'default-frame-alist '(font . "jetbrainsmono nerd font-12"))
					; set indentation style for c
(setq c-default-style "k&r" c-basic-offset 4)

;; Keybinds
(defun reload-config ()
  (interactive)
  (load-file "~/.config/emacs/init.el"))
;(global-set-key (kbd "C-x r") 'reload-config)

;; mouse
(setq mouse-wheel-progressive-speed nil
      mouse-wheel-scroll-amount '(4
  ((shift) . hscroll)
  ((meta))
  ((control) . text-scale)))
