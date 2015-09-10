;;; packages.el --- stuff Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq stuff-packages
      '(
        ;; package stuffs go here
        evil-paredit
        glsl-mode
        ;; mouse-slider-mode
        ;; palette
        ;; racket-mode
        ))

;; List of packages to exclude.
(setq stuff-excluded-packages '())

;; For each package, define a function stuff/init-<package-stuff>
;;
;; (defun stuff/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

(defun stuff/init-evil-paredit ()
  (use-package evil-paredit
    :defer t
    :init
    (progn
      (add-hook 'emacs-lisp-mode-hook       'evil-paredit-mode)
      (add-hook 'eval-expression-minibuffer-setup-hook 'evil-paredit-mode)
      (add-hook 'ielm-mode-hook             'evil-paredit-mode)
      (add-hook 'lisp-mode-hook             'evil-paredit-mode)
      (add-hook 'lisp-interaction-mode-hook 'evil-paredit-mode)
      (add-hook 'scheme-mode-hook           'evil-paredit-mode)

      ;; (add-hook 'slime-repl-mode-hook (lambda () (evil-paredit-mode +1)))
      )))

(defun stuff/init-glsl-mode ()
  (use-package glsl-mode
    :defer t
    :mode ("\\.\\(vert\\|frag\\|geom\\|glsl\\)\\'" . glsl-mode)))

;; (defun stuff/init-mouse-slider-mode ()
;;   (use-package mouse-slider-mode
;;     :defer t
;;     :commands mouse-slider-mode
;;     :config
;;     (progn
;;       (add-to-list 'mouse-slider-mode-eval-funcs
;;                    '(lisp-mode . slime-compile-defun))
;;       ;; (setq mouse-slider-scale 1000)
;;       )))
