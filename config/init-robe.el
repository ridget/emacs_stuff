(defgroup dotemacs-robe nil
  "Configuration options for robe mode."
  :group 'dotemacs
  :prefix 'dotemacs-robe)

(require-package 'robe)
(require 'robe)

(add-hook 'ruby-mode-hook 'robe-mode)
(eval-after-load 'company
  '(push 'company-robe company-backends))

(provide 'init-robe)
