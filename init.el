(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9a977ddae55e0e91c09952e96d614ae0be69727ea78ca145beea1aae01ac78d2"
     "99d1e29934b9e712651d29735dd8dcd431a651dfbe039df158aa973461af003e"
     "b1df4108859ad7f683d66f5d3af07f35ae301234c77b5dbdc347e67b8b0c8b4c"
     "810a6a4ad0dd1cc1acfae6be09a00f1210105d1f8e62a0eeebb765980a2caa51"
     "18631300c9090ac9f588b07d0ef4b1d093143a31e8c8c29e9fc2a57db1cdf502"
     default))
 '(package-selected-packages
   '(ace-window bufler company-native-complete corfu docker
		dockerfile-mode dumb-jump eglot-fsharp ess f forge
		format-all fsharp-mode htmlize httpd ledger-mode
		marginalia modus-themes ob-sharp orderless org-modern
		paredit plz poly-R simple-httpd smartparens
		sr-speedbar vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package emacs
  :ensure nil
  :custom
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  :config
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-truncate-lines 1)
  (global-display-line-numbers-mode 1)
  (delete-selection-mode 1)
  (global-hl-line-mode)
  ;; conflict between corfu completion and c mode map
  ;; see https://github.com/minad/corfu/issues/34#issuecomment-903308126
  (add-hook 'c-mode (lambda ((when (equal tab-always-indent 'complete)
			       (define-key c-mode-base-map [remap c-indent-line-or-region] #'completion-at-point)))))
  (setq use-short-answers t
	use-dialog-box nil
	inhibit-startup-message t
	mac-option-modifier 'meta
	fill-column 80))

;; can i make due without these?
;; (use-package f)
;; (use-package s)
;; (use-package dash)

(use-package paredit)

(use-package docker
  :bind ("C-c d" . docker))
(use-package dockerfile-mode)

(use-package treesit
  :ensure nil
  :config
  (dolist (grammar '((r . ("https://github.com/r-lib/tree-sitter-r" "v1.1.0"))
		     (python . ("https://github.com/tree-sitter/tree-sitter-python" "v0.23.2"))))
    (add-to-list 'treesit-language-source-alist grammar)))

(use-package dumb-jump
  :config
  (setq xref-show-definitions-function #'xref-show-definitions-completing-read)
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package org
  :ensure nil
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (R . t)
     (shell . t)
     (sql . t)
     (fsharp . t)))
  (setq org-confirm-babel-evaluate
	;; return t if user should be prompted, nil otherwise
	(lambda (lang body)
	  ;; 2025-01-04 - I used this to whitelist some languages, but it kept
	  ;; getting in the way. Changed to just allow execution
	  ;;
	  ;; (let ((trusted-languages (list "elisp" "R" "sql" "fsharp")))
	  ;;   (not (member lang trusted-languages)))
	  nil)
	org-agenda-files (list org-directory)
	org-refile-targets '((org-agenda-files . (:maxlevel . 3)))
	org-refile-use-outline-path t
	org-outline-path-complete-in-steps nil
	org-startup-indented t
	org-hide-leading-stars t
	org-agenda-files (list "~/gtd")
	fill-column 80))

(use-package modus-themes
  :config
  (setq modus-themes-org-blocks 'gray-background)
  (load-theme 'modus-operandi-tinted))

(use-package vertico
  :custom
  (vertico-cycle t)
  (readbuffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (completion-styles '(basic substring partial-completion flex))
  :init
  (vertico-mode))

(use-package marginalia
  :after vertico
  :init (marginalia-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles partial-completion)))))

(use-package hideshow
  :config
  (define-key hs-minor-mode-map (kbd "C-c C-h") (lookup-key hs-minor-mode-map (kbd "C-c @")))
  :hook ((prog-mode . hs-minor-mode)))

;; (use-package company
;;   :hook ((after-init . global-company-mode))
;;   :custom (company-idle-delay 0))

;; (use-package company-native-complete
;;   :config
;;   (add-to-list 'company-backends 'company-native-complete)
;;   (setq comint-prompt-regex "^.+[$%>] "))

(use-package savehist
  :init
  (savehist-mode))

(use-package which-key
  :config
  (which-key-mode))

(use-package ess
  :vc (ess :url "https://github.com/emacs-ess/ESS"
	   :branch "tree-sitter"
	   :lisp-dir "lisp")
  :init
  ;; bind-key is required to set key bindings
  ;; ess-site is required to have the r mode maps available
  (require 'bind-key)
  (add-to-list 'load-path "~/.config/emacs/elpa/ess/lisp/")
  (require 'ess-site)
  :config
  (setq ess-auto-width 'window
	ess-history-directory "~/iCloud/"
	ess-history-file t)
  :bind
  (:map inferior-ess-r-mode-map
	(("C->" . "|>")
	 ("C-<" . "<-"))
	:map ess-r-mode-map
	(("C->" . "|>")
	 ("C-<" . "<-"))))

(use-package polymode)

(use-package poly-R)

(use-package format-all
  :bind ("M-F" . format-all-region-or-buffer))

(use-package magit)

(use-package forge
  :after magit)

(use-package ace-window
  :config (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind ("M-o" . ace-window))

(use-package smartparens
  :hook ((prog-mode . smartparens-mode)))

(use-package ledger-mode
  :config
  (defun ejneer-ledger-navigate-next-xact-or-directive ()
    "go to next transcation and highlight first posting"
    (interactive)
    (progn
      (ledger-navigate-next-xact-or-directive)
      (let* ((p1 (- (re-search-forward "^    [^;]") 1))
	     (p2 (progn
		   (goto-char p1)
		   (goto-char (line-end-position))
		   (+ 1 (re-search-backward "[a-zA-Z0-9]  +")))))
	(push-mark p1)
	(goto-char p2)
	(setq mark-active t))))
  :bind (:map ledger-mode-map
	      ("M-n" . ejneer-ledger-navigate-next-xact-or-directive)))

(use-package fsharp-mode
  :bind
  (:map fsharp-mode-map
	(("C->" . "->"))))

(use-package eglot-fsharp
  :after fsharp-mode)

(use-package ob-fsharp
  :after org)

(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.

  :init
  (setq corfu-auto nil
	corfu-quit-no-match 'separator)
  (global-corfu-mode))

;; serve personal website files so I can see styling from css files
(use-package simple-httpd)
