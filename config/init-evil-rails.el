(load "evil-rails/evil-rails")
(defun alternate-in-vertical-split ()
  (interactive)
  (evil-window-vsplit)
  (projectile-toggle-between-implementation-and-test))
(evil-ex-define-cmd "AV" 'alternate-in-vertical-split)
(evil-ex-define-cmd "buffers" 'helm-buffers-list)
(provide 'init-evil-rails)

