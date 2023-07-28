(straight-use-package 'use-package)

(eval-when-compile (require 'use-package))

(use-package corfu
  :straight t
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (c`orfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-exclude-modes'.
  :init
  (global-corfu-mode))

(use-package eglot
  :hook (c-mode . eglot-ensure)
  :config
  (setq completion-category-defaults nil))

;; A few more useful configurations...
(use-package emacs
  :bind (("C-x w v" . split-window-horizontally)
	 ("C-x w b" . split-window-vertically)
	 ("C-x w l" . windmove-right)
	 ("C-x w j" . windmove-down)
	 ("C-x w k" . windmove-up)
	 ("C-x w h" . windmove-left))
  :init
  (setq make-backup-files nil)
  (setq completion-cycle-threshold 3)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  (setq read-extended-command-predicate
         #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(use-package vterm
  :straight t)

(use-package sly
  :straight t)

(use-package evil
  :straight t
  :config
  (evil-mode 1))

(use-package doom-themes
  :straight t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-flatwhite t)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
