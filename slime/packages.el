;;; packages.el --- slime Layer packages File for Spacemacs
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

(setq slime-packages
      '(slime
        slime-company))

(defun slime/init-slime ()
  (use-package slime
    :commands slime-mode
    :init
    (progn
      (setq slime-contribs '(slime-fancy
                             slime-indentation
                             slime-sbcl-exts
                             slime-scratch
                             ;; slime-mdot-fu
                             ;; slime-trace-dialog
                             )
            inferior-lisp-program "sbcl")
      ;; enable fuzzy matching in code buffer and SLIME REPL

      (setq slime-complete-symbol*-fancy t)
      (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
      ;; enable smartparen in code buffer and SLIME REPL
      ;; (add-hook 'slime-repl-mode-hook #'smartparens-strict-mode)
      (defun slime/disable-smartparens ()
        (smartparens-strict-mode -1)
        (turn-off-smartparens-mode))
      (add-hook 'slime-repl-mode-hook #'slime/disable-smartparens)
      (spacemacs/add-to-hooks 'slime-mode '(lisp-mode-hook)))
    :config
    (progn
      (dolist (m `(,slime-mode-map ,slime-repl-mode-map))
        (define-key m [(tab)] 'slime-fuzzy-complete-symbol))
      (dolist (m '(lisp-mode
                   slime-repl-mode))
        (evil-leader/set-key-for-mode m
          "cc" 'slime-compile-file
          "cC" 'slime-compile-and-load-file
          "cf" 'slime-compile-defun
          "cr" 'slime-compile-region

          "ds" 'slime-disassemble-symbol
          "dd" 'slime-disassemble-definition
          "db" 'slime-interrupt
          "do" 'slime-inspect-definition
          "di" 'slime-inspect

          "eb" 'slime-eval-buffer
          "ef" 'slime-eval-defun
          "ee" 'slime-eval-last-sexp
          "er" 'slime-eval-region

          "gb" 'slime-pop-find-definition-stack
          "gg" 'slime-edit-definition
          "gG" 'slime-edit-definition-other-window
          "gn" 'slime-next-note
          "gN" 'slime-previous-note
          "gp" 'slime-previous-note

          "ha" 'slime-apropos
          "hf" 'slime-describe-function
          "hh" 'slime-hyperspec-lookup
          "hs" 'slime-describe-symbol

          "ma" 'slime-macroexpand-all
          "me" 'slime-macroexpand-1

          "pf" 'slime-toggle-profile-fdefinition
          "pF" 'slime-profiled-functions
          "pp" 'slime-profile-package
          "pr" 'slime-profile-report
          "pR" 'slime-profile-reset
          "ps" 'slime-profile-by-substring
          "pu" 'slime-unprofile-all

          "sc" 'slime-cd
          "sC" 'slime-repl-clear-buffer
          "se" 'slime-eval-last-expression-in-repl
          "si" 'slime
          "sp" 'slime-pwd
          "sq" 'slime-quit-lisp
          "sr" 'slime-restart-inferior-lisp

          "tf" 'slime-toggle-fancy-trace
          "tt" 'slime-toggle-trace-fdefinition
          "tu" 'slime-untrace-all

          "wb" 'slime-who-binds
          "wc" 'slime-who-calls
          "wm" 'slime-who-macroexpands
          "wr" 'slime-who-references
          "ws" 'slime-who-sets
          "wS" 'slime-who-specializes)))))

(defun stuff/init-slime-company ()
  (use-package slime-company
    :config
    (slime-setup '(slime-company))
    (progn
      (define-key company-active-map (kbd "\C-n") 'company-select-next)
      (define-key company-active-map (kbd "\C-p") 'company-select-previous)
      (define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
      (define-key company-active-map (kbd "<tab>") 'company-complete))))

