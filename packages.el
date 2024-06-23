(straight-use-package 'use-package)

(eval-when-compile (require 'use-package))

(use-package auto-package-update
  :straight t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package flycheck
  :straight t)

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


(use-package vertico
  :straight t
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Configure directory extension.
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :straight t
  :init
  (savehist-mode))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :straight t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; IDO

;; (use-package ido
;;   :straight t
;;   :config
;;   (setq ido-everywhere t
;;     ido-virtual-buffers t
;;     ido-use-faces t
;;     ido-default-buffer-method 'selected-window
;;     ido-auto-merge-work-directories-length -1)
;;   (ido-mode))
;; (use-package flx-ido :straight t :requires ido :config (flx-ido-mode))
;; (use-package ido-vertical-mode :straight t :requires ido :config (ido-vertical-mode))
;; (use-package ido-completing-read+ :straight t :requires ido
;;   :config
;;   (setq ido-ubiquitous-max-items 50000
;;     ido-cr+-max-items 50000)
;;   (ido-ubiquitous-mode +1))

(use-package clojure-mode
  :straight t)

(use-package cider
  :straight t)

(use-package rust-mode
  :straight t)

(use-package rustic
  :straight t
  :config
  (setq rustic-lsp-client 'eglot))

(use-package haskell-mode
  :straight t)

(use-package python-mode
  :straight t)

(use-package racket-mode
  :straight t)

(use-package eglot
  :hook ((haskell-mode . eglot-ensure)
	 (c-mode . eglot-ensure)
	 (racket-mode . eglot-ensure)
	 (python-mode . eglot-ensure)
	 (rust-mode . eglot-ensure)
	 (clojure-mode . eglot-ensure))
  
  :config
  (setq completion-category-defaults nil)
  (add-to-list 'eglot-server-programs 
             '(haskell-mode . ("haskell-language-server-wrapper" "--lsp")))
  (add-to-list 'eglot-server-programs
               '((rust-ts-mode rust-mode) .
		 ("rust-analyzer" :initializationOptions (:check (:command "clippy"))))))

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
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Support opening new minibuffers from inside existing minibuffers.
  (setq enable-recursive-minibuffers t)

  ;; Emacs 28 and newer: Hide commands in M-x which do not work in the current
  ;; mode.  Vertico commands are hidden in normal buffers. This setting is
  ;; useful beyond Vertico.
  (setq read-extended-command-predicate #'command-completion-default-include-p)
  
  (setq make-backup-files nil)
  (setq completion-cycle-threshold 3)
<<<<<<< HEAD
  (setq ring-bell-function 'ignore)
=======
  
>>>>>>> c62d2d3 (Add corfu)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  (setq read-extended-command-predicate
         #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete)
  )

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
  :bind ("C-c t" . vterm))

;;(use-package sly
;;  :straight t)

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

(use-package dashboard
  :straight t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "I'm sorry, Dave. I'm afraid I can't do that.") 
  (setq dashboard-startup-banner "~/.emacs.d/splash.png")
  (setq dashboard-center-content t))
