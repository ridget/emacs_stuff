(require-package 'smartparens)
(require-package 'evil-smartparens)

(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)

(add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)


(provide 'init-smartparens)
