(defgroup dotemacs-web nil
  "Configuration options for web."
  :group 'dotemacs
  :prefix 'dotemacs-web)

(defcustom dotemacs-web/indent-offset 2
  "The number of spaces to indent nested statements."
  :type 'integer
  :group 'dotemacs-web)

(defcustom dotemacs-web/use-skewer-mode nil
  "When non-nil, enables `skewer-mode' integration."
  :type 'boolean
  :group 'dotemacs-web)

(defcustom dotemacs-web/use-emmet-mode nil
  "When non-nil, enables `emmet-mode' integration."
  :type 'boolean
  :group 'dotemacs-web)


(lazy-major-mode "\\.coffee\\'" coffee-mode)
(lazy-major-mode "\\.jade$" jade-mode)
(lazy-major-mode "\\.scss$" scss-mode)
(lazy-major-mode "\\.sass$" sass-mode)
(lazy-major-mode "\\.less$" less-css-mode)


(when dotemacs-web/use-skewer-mode
  (require-package 'skewer-mode)
  (skewer-setup))


(when dotemacs-web/use-emmet-mode
  (defun my-emmet-mode ()
    (require-package 'emmet-mode)
    (emmet-mode))

  (add-hook 'css-mode-hook #'my-emmet-mode)
  (add-hook 'sgml-mode-hook #'my-emmet-mode)
  (add-hook 'web-mode-hook #'my-emmet-mode))


(require-package 'rainbow-mode)
(add-hook 'html-mode-hook #'rainbow-mode)
(add-hook 'web-mode-hook #'rainbow-mode)
(add-hook 'css-mode-hook #'rainbow-mode)
(add-hook 'stylus-mode-hook #'rainbow-mode)


(lazy-major-mode "\\.html?$" web-mode)


(when dotemacs-js/use-web-mode
  (lazy-major-mode "\\.jsx?$" web-mode))


(after 'web-mode
  (add-hook 'web-mode-hook
            (lambda ()
              (electric-pair-mode -1)
              (and (fboundp #'smartparens-mode) (smartparens-mode -1))))

  (setq web-mode-code-indent-offset dotemacs-web/indent-offset)
  (setq web-mode-markup-indent-offset dotemacs-web/indent-offset)
  (setq web-mode-css-indent-offset dotemacs-web/indent-offset)
  (setq web-mode-sql-indent-offset dotemacs-web/indent-offset)

  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-element-content-fontification t)
  (setq web-mode-enable-element-tag-fontification t)
  (setq web-mode-enable-html-entities-fontification t)
  (setq web-mode-enable-inlays t)
  (setq web-mode-enable-sql-detection t)
  (setq web-mode-enable-block-face t)
  (setq web-mode-enable-part-face t))


;; indent after deleting a tag
(defadvice sgml-delete-tag (after dotemacs activate)
  (indent-region (point-min) (point-max)))


(provide 'init-web)
