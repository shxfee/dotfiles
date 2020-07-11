;; Emacs Configuration
;; @author <shxfee@gmail.com>

;; ========================================
;; PACKAGES
;; ========================================
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-w-in-emacs-state t)
  :config
  (define-key evil-normal-state-map (kbd "-") 'dired-jump)
  (evil-mode 1))

(use-package projectile
  :init
  (setq helm-projectile-fuzzy-match nil)
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (use-package helm-projectile
    :config
    (helm-projectile-on)))

(use-package fzf)


(use-package php-mode
  :init
  (add-hook 'php-mode-hook
	    '(lambda ()
	       (auto-complete-mode t)

	       (use-package ac-php)
	       (setq ac-sources '(ac-source-php))

	       (yas-global-mode 1)
	       (ac-php-core-eldoc-setup)

	       (define-key php-mode-map (kbd "M-]")
		 'ac-php-find-symbol-at-point)

	       (define-key php-mode-map (kbd "M-[")
		 'ac-php-location-stack-back)))
  )

(use-package jbeans-theme
  :config
  (load-theme 'jbeans t))

(use-package helm
  :init
  (setq-default helm-M-x-fuzzy-match t)
  :bind
  (("M-x" . helm-M-x)
   ("M-f" . helm-find-files))
  :config
  (helm-mode 1))

(use-package helm-fd
  :bind (:map helm-command-map
	      ("/" . helm-fd)))

(use-package auto-complete
  :config
  (ac-config-default))

(use-package ls-lisp
  :ensure nil
  :init
  (setq ls-lisp-dirs-first t)
  (setq ls-lisp-use-insert-directory-program nil))
  
(use-package dired-x :ensure nil)

;; ========================================
;; KEY BINDINGS
;; ========================================
(global-set-key (kbd "C-x .") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))


;; ========================================
;; HOOKS
;; ========================================
(add-hook 'dired-mode-hook
	  (lambda ()
	    (local-set-key (kbd "-") 'dired-up-directory)
	    (dired-hide-details-mode)))


;; ========================================
;; Config Vars
;; ========================================
(menu-bar-mode -1)
(global-display-line-numbers-mode)

(require 'hl-line)
(set-face-attribute 'hl-line nil :inherit nil :background "color-234")

(global-hl-line-mode 1)

(setq initial-buffer-choice t)

(setq
 scroll-step 1
 scroll-conservatively 10000)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-fd ac-php php-mode web-mode use-package projectile jbeans-theme helm evil auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
