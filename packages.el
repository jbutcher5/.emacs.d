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
  :bind (("C-c v" . split-window-horizontally)
	 ("C-c b" . split-window-vertically)
	 ("C-c l" . windmove-right)
	 ("C-c j" . windmove-down)
	 ("C-c k" . windmove-up)
	 ("C-c h" . windmove-left)
	 ("C-c c" . delete-window))
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

(use-package projectile
  :straight t
  :bind-keymap ("C-c p" . projectile-command-map))

(use-package magit
  :straight t
  :bind (("C-x g" . magit-status)
	 ("C-c g" . magit-dispatch)
	 ("C-c g" . magit-file-dispatch)))

(use-package vterm
  :straight t
  :bind ("C-c t" . vterm)
  :init
  (setq shell-file-name "/usr/bin/bash"))

(use-package sly
  :straight t)

(use-package evil
  :straight t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :straight t
  :config
  (evil-collection-init))

(use-package doom-themes
  :straight t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'modus-vivendi t)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1))

(use-package xwidget
  :bind ("C-c w" . (lambda () (interactive) (xwidget-webkit-browse-url "https://duck.com")))
  :hook ((xwidget-webkit-mode . (lambda () (evil-mode 0)))
	 (buffer-list-update . (lambda () (unless (eq major-mode 'minibuffer-inactive-mode)
					    (evil-mode (if (derived-mode-p 'xwidget-webkit-mode) 0 1)))))))

(use-package dashboard
  :straight t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "I'm sorry, Dave. I'm afraid I can't do that.") 
  (setq dashboard-startup-banner "~/.emacs.d/splash.png")
  (setq dashboard-center-content t))
