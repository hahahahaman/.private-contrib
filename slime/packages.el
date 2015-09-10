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
          "mcc" 'slime-compile-file
          "mcC" 'slime-compile-and-load-file
          "mcf" 'slime-compile-defun
          "mcr" 'slime-compile-region

          "mdb" 'slime-interrupt
          "mdi" 'slime-inspect-definition
          "mdI" 'slime-inspect

          "meb" 'slime-eval-buffer
          "mef" 'slime-eval-defun
          "mee" 'slime-eval-last-sexp
          "mer" 'slime-eval-region

          "mgb" 'slime-pop-find-definition-stack
          "mgg" 'slime-edit-definition
          "mgG" 'slime-edit-definition-other-window
          "mgn" 'slime-next-note
          "mgN" 'slime-previous-note
          "mgp" 'slime-previous-note

          "mha" 'slime-apropos
          "mhd" 'slime-disassemble-symbol
          "mhD" 'slime-disassemble-definition
          "mhf" 'slime-describe-function
          "mhh" 'slime-hyperspec-lookup
          "mhs" 'slime-describe-symbol

          "mma" 'slime-macroexpand-all
          "mme" 'slime-macroexpand-1

          "mpf" 'slime-toggle-profile-fdefinition
          "mpF" 'slime-profiled-functions
          "mpp" 'slime-profile-package
          "mpr" 'slime-profile-report
          "mpR" 'slime-profile-reset
          "mps" 'slime-profile-by-substring
          "mpu" 'slime-unprofile-all

          "msc" 'slime-cd
          "msC" 'slime-repl-clear-buffer
          "mse" 'slime-eval-last-expression-in-repl
          "msi" 'slime
          "msp" 'slime-pwd
          "msq" 'slime-quit-lisp
          "msr" 'slime-restart-inferior-lisp

          "mtf" 'slime-toggle-fancy-trace
          "mtt" 'slime-toggle-trace-fdefinition
          "mtu" 'slime-untrace-all

          "mwb" 'slime-who-binds
          "mwc" 'slime-who-calls
          "mwm" 'slime-who-macroexpands
          "mwr" 'slime-who-references
          "mws" 'slime-who-sets
          "mwS" 'slime-who-specializes)))))

(defun stuff/init-slime-company ()
  (use-package slime-company
    :config
    (slime-setup '(slime-company))
    (progn
      (define-key company-active-map (kbd "\C-n") 'company-select-next)
      (define-key company-active-map (kbd "\C-p") 'company-select-previous)
      (define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
      (define-key company-active-map (kbd "<tab>") 'company-complete))))

