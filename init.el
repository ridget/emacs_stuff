(defgroup dotemacs nil
  "Custom configuration for dotemacs."
  :group 'local)

(defcustom dotemacs-cache-directory (concat user-emacs-directory ".cache/")
  "The storage location for various persistent files."
  :group 'dotemacs)

(defcustom dotemacs-completion-engine
  'company
  "The completion engine the use."
 :type '(radio
          (const :tag "company-mode" company)
          (const :tag "auto-complete-mode" auto-complete))
  :group 'dotemacs)

(setq user-emacs-directory (file-truename "~/.emacs.d/"))

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless (display-graphic-p) (menu-bar-mode -1))

(add-to-list 'load-path (concat user-emacs-directory "config"))
(add-to-list 'load-path (concat user-emacs-directory "lisp/"))
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

(setq ruby-deep-indent-paren nil)
(setq evil-vsplit-window-right t)

(require 'cl)
(require 'init-packages)
(require 'init-util)
(let ((debug-on-error t))
  (require 'init-core)
  (if (eq dotemacs-completion-engine 'company)
      (require 'init-company)
    (require 'init-auto-complete))
  (require 'init-projectile)
  (require 'init-helm)
  (require 'init-smartparens)
  (require 'init-ido)
  (require 'init-flymake-ruby)
  (require 'init-evil)
  (require 'init-evil-rails)
  (require 'init-rbenv)
  (require 'init-linum-relative)
  (require 'init-robe)
  (require 'init-rspec-mode)
  (require 'init-bindings))

(evilnc-default-hotkeys)

(load-theme 'solarized-dark t)
