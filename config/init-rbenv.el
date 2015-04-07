(require-package 'rbenv)
(setq rbenv-installation-dir "/usr/local/var/rbenv")

(require 'rbenv)
(global-rbenv-mode)
(setq rbenv-show-active-ruby-in-modeline nil)

(provide 'init-rbenv)
