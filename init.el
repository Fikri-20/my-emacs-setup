;; ==============================
;; Basic Settings
;; ==============================
(setq inhibit-startup-message t
      make-backup-files nil
      auto-save-default nil
      create-lockfiles nil
      ring-bell-function 'ignore
      user-full-name "Fikri"
      user-mail-address "fikri@example.com")

;; Zoom In (Ctrl+Shift+=) and Zoom Out (Ctrl+-)
(global-set-key (kbd "C-+") (lambda () (interactive) (text-scale-increase 1)))
(global-set-key (kbd "C-=") (lambda () (interactive) (text-scale-increase 1))) ;; For some keyboards
(global-set-key (kbd "C--") (lambda () (interactive) (text-scale-decrease 1)))
(global-set-key (kbd "C-0") (lambda () (interactive) (text-scale-set 0))) ;; Reset zoom


;; Set default directory (optional)
;; (setq default-directory "~/Documents/")

;; Load package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if missing
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; ==============================
;; UI Enhancements
;; ==============================
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)
(column-number-mode t)
(setq display-line-numbers-type 'relative)
(load-theme 'modus-operandi t)


;; ==============================
;; Org-mode Configuration
;; ==============================
(use-package org
  :config
  ;; Prettier headlines with bullets
  (use-package org-superstar
    :hook (org-mode . org-superstar-mode)
    :config
    (setq org-superstar-headline-bullets-list '("●" "○" "◆" "◇" "■" "□")))

  ;; Indentation and visuals
  (setq org-hide-emphasis-markers t
        org-startup-indented t
        org-pretty-entities t))
;; Install org-modern
(use-package org-modern
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda)
  :config
  ;; Minimal, clean styling
  (setq org-modern-star ["●" "○" "◆" "◇" "■" "□"])
  (setq org-modern-table-vertical 1
        org-modern-table-horizontal 1)
  ;; Hide leading stars for a neat outline
  (setq org-modern-hide-stars t)
  ;; Use a subtle symbol for TODOs
  (setq org-modern-todo "◉"
        org-modern-done "✔"))



;; Align tables nicely
(use-package valign
  :hook ((org-mode . valign-mode)))

;; ==============================
;; Org Babel for Programming
;; ==============================
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (python . t)
   (js . t)
   (sql . t)))

;; ==============================
;; LaTeX Support
;; ==============================
(use-package auctex
  :defer t)

(use-package cdlatex
  :hook (org-mode . turn-on-org-cdlatex))

(setq org-latex-create-formula-image-program 'dvipng)

;; ==============================
;; GitHub and Version Control
;; ==============================
(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit-status))

;; ==============================
;; LSP and Programming
;; ==============================
(use-package lsp-mode
  :hook ((c-mode c++-mode python-mode js-mode typescript-mode) . lsp)
  :commands lsp
  :config
  (setq lsp-prefer-flymake nil))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1))

(use-package flycheck
  :init (global-flycheck-mode))

;; ==============================
;; Better File Navigation
;; ==============================
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c C-r" . ivy-resume))
  :config
  (ivy-mode 1))

(use-package counsel)
(use-package swiper)

;; -------------------------
;; Openwith configuration
;; -------------------------
(use-package openwith
  :ensure t
  :config
  (openwith-mode 1)
  (setq openwith-associations
        '(("\\.pdf\\'" "evince" (file))
          ("\\.mp4\\'" "vlc" (file))
          ("\\.jpg\\'" "xdg-open" (file))
          ("\\.png\\'" "xdg-open" (file))
          ("\\.docx\\'" "libreoffice" (file))
          ("\\.xlsx\\'" "libreoffice" (file))
          ("\\.html\\'" "firefox" (file)))))

 (require 'doom-modeline)
 (doom-modeline-mode 1)


;; ==============================
;; Save Customizations Separately
;; ==============================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)
