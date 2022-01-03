;;; package --- Summary
;;; Commentary
;; For straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

;; Constants
(setq user-full-name "Sam Heaton"
      user-login-name "heat"
      user-mail-address ""
      user-emacs-directory "~/.emacs.d"

      ;; Backups, autosave
      backup-directory-alist '(("." . "~/.emacs.d/backups"))
      delete-old-versions t
      version-control t
      vc-make-backup-files t
      auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))

      ;; File history
      savehist-file "~/.emacs.d/savehist"
      history-length t
      history-delete-duplicates t
      savehist-save-minibuffer-history 1
      savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring)

      ;; Encoding
      file-name-coding-system 'utf-8
      buffer-file-coding-system 'utf-8
      coding-system-for-write 'utf-8
      locale-coding-system 'utf-8
      default-process-coding-system '(utf-8 . utf-8)

      ;; Misc settings
      inhibit-startup-screen t
      inhibit-compacting-font-caches t
      ring-bell-function 'ignore
      confirm-kill-emacs 'y-or-n-p

      ;; Formatting
      ;; indent-line-function 'insert-tab
      line-spacing 2
      sentence-end-double-space nil
      gc-cons-threshold 100000000
      lsp-completion-provider :capf
      lsp-idle-delay 0.500
      read-process-output-max (* 1024 1024)) ; 1mb

(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'horizontal-scroll-bar-mode nil)

(setq-default tab-width 2
              indent-tabs-mode nil)
(setq standard-indent 2)
(add-hook 'js-mode-hook
          (function (lambda ()
                      (setq indent-tabs-mode nil
                            tab-width 2))))

;; Completely disable the mouse
                                        ; (dolist (key '([drag-mouse-1] [down-mouse-1] [mouse-1]
                                        ;                [drag-mouse-2] [down-mouse-2] [mouse-2]
                                        ;                [drag-mouse-3] [down-mouse-3] [mouse-3]))
                                        ;   (global-unset-key key))

;; Disable arrow key movement
(dolist (key '("<left>" "<right>" "<up>" "<down>"))
  (global-unset-key (kbd key)))
(global-set-key (kbd "M-?") 'help-command)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

;; Global modes
(savehist-mode 1)
(save-place-mode 1)
(fringe-mode 0)
(fset 'yes-or-no-p 'y-or-n-p)
(column-number-mode 1)
(delete-selection-mode 1)
(show-paren-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(flymake-mode 0)
(global-hl-line-mode 1)
(global-subword-mode 1)
(global-visual-line-mode t)
(global-display-line-numbers-mode t)

;; Hooks
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode) ; Text wrap
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Encoding
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

;; Unbind Pesky Sleep Button
(global-unset-key [(control z)])
(global-unset-key [(control x)(control z)])

;; Unbind List directory (brief)
(global-unset-key (kbd "C-x C-d"))

;; Package installation
(straight-use-package 'rainbow-delimiters)
(straight-use-package 'smartparens)
(straight-use-package 'magit)
(straight-use-package 'forge)
(straight-use-package 'doom-themes)
(straight-use-package 'doom-modeline)
(straight-use-package 'all-the-icons)
(straight-use-package 'emojify)
(straight-use-package 'yaml-mode)
(straight-use-package 'json-mode)
(straight-use-package 'web-mode)
;;(straight-use-package 'js2-mode)
(straight-use-package 'dotenv-mode)
(straight-use-package 'lsp-mode)
(straight-use-package 'flycheck-inline)
(straight-use-package 'flycheck-status-emoji)
(straight-use-package 'projectile)
(straight-use-package 'helm)
(straight-use-package 'helm-swoop)
(straight-use-package 'company)
(straight-use-package 'helm-company)
(straight-use-package 'which-key)
(straight-use-package 'treemacs)
(straight-use-package 'treemacs-projectile)
(straight-use-package 'treemacs-icons-dired)
(straight-use-package 'treemacs-magit)
(straight-use-package 'lsp-treemacs)
(straight-use-package 'undo-tree)
                                        ;(straight-use-package 'disable-mouse)
(straight-use-package 'good-scroll)
(straight-use-package 'eslintd-fix)
;; (straight-use-package 'tide)
(straight-use-package 'hl-todo)
(straight-use-package 'pcre2el)
(straight-use-package 's)
(straight-use-package 'magit-todos)
(straight-use-package 'dap-mode)

;; magit-todos

(require 'magit-todos)

;;; dap-mode
(setq dap-auto-configure-features '(sessions locals controls tooltip))

;; TypeScript
;; lsp-mode for ts server with js2-mode for highlighting and dap-mode for debugging

(straight-use-package 'typescript-mode)
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)

(add-hook 'typescript-mode-hook (function
                                 (lambda ()
                                   ;; tree-sitter
                                   (require 'tree-sitter)
                                   (require 'tree-sitter-langs)
                                   (global-tree-sitter-mode)
                                   (tree-sitter-hl-mode)
                                   ;; format on save
                                   ;; (add-hook 'before-save-hook 'lsp-format-buffer)
                                   ;; formatting
                                   (setq web-mode-enable-auto-quoting nil)
                                   (setq web-mode-markup-indent-offset 2)
                                   (setq web-mode-code-indent-offset 2)
                                   (setq web-mode-attr-indent-offset 2)
                                   (setq web-mode-attr-value-indent-offset 2)
                                   (setq-default tab-width 2)
                                   ;; lsp
                                   (lsp)
                                   ;; syntax check
                                   (flycheck-mode +1)
                                   (setq company-tooltip-align-annotations t)
                                   (eldoc-mode +1)
                                   (setq flycheck-check-syntax-automatically '(save mode-enabled))
                                   (setq flycheck-checker 'lsp)
                                   ;; debugging
                                   (require 'dap-node)
                                   (dap-node-setup)
                                   (dap-mode 1)
                                   (dap-ui-mode 1)
                                   ;; enables mouse hover support
                                   (dap-tooltip-mode 1)
                                   ;; use tooltips for mouse hover
                                   ;; if it is not enabled `dap-mode' will use the minibuffer.
                                   (tooltip-mode 1)
                                   ;; displays floating panel with debug buttons
                                   ;; requies emacs 26+
                                   (dap-ui-controls-mode 1)
                                   ;; Completion
                                   (company-mode +1))))

;; #########################################
;; ############# Helm settings #############
;; #########################################

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)
(add-hook 'helm-major-mode-hook
          (lambda ()
            (setq auto-composition-mode nil)))

;; #########################################
;; ########## Helm swoop settings ##########
;; #########################################
(require 'helm-swoop)

;; C-s in a buffer: open helm-swoop with empty search field
(global-set-key (kbd "C-s") 'helm-swoop)
(with-eval-after-load 'helm-swoop
  (setq helm-swoop-pre-input-function
        (lambda () nil)))

;; C-s in helm-swoop with empty search field: activate previous search.
;; C-s in helm-swoop with non-empty search field: go to next match.
(with-eval-after-load 'helm-swoop
  (define-key helm-swoop-map (kbd "C-s") 'tl/helm-swoop-C-s))

(defun tl/helm-swoop-C-s ()
  (interactive)
  (if (boundp 'helm-swoop-pattern)
      (if (equal helm-swoop-pattern "")
          (previous-history-element 1)
        (helm-next-line))
    (helm-next-line)))

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
(define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

;; Move up and down like isearch
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

;; Helm-swoop constants
(setq helm-multi-swoop-edit-save t ; Save buffer when helm-multi-swoop-edit complete
      ;; If this value is t, split window inside the current window
      helm-swoop-split-with-multiple-windows t
      ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
      helm-swoop-split-direction 'split-window-vertically
      ;; If nil, you can slightly boost invoke speed in exchange for text color
      helm-swoop-speed-or-color t
      ;; Go to the opposite side of line from the end or beginning of line
      helm-swoop-move-to-line-cycle t
      ;; Optional face for line numbers
      ;; Face name is `helm-swoop-line-number-face`
      helm-swoop-use-line-number-face t
      ;; If you prefer fuzzy matching
      helm-swoop-use-fuzzy-match t)

(add-to-list 'display-buffer-alist
             `(,(rx bos "*helm" (* not-newline) "*" eos)
               (display-buffer-in-side-window)
               (inhibit-same-window . t)
               (window-height . 0.4)))

;; #########################################
;; ########### Flycheck settings ###########
;; #########################################

(global-flycheck-mode)
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

;; #########################################
;; ######## Which-key-mode settings ########
;; #########################################
(which-key-mode)
(which-key-setup-side-window-right-bottom)

;; #########################################
;; ########## Undo tree settings ###########
;; #########################################
(global-undo-tree-mode)

;; #########################################
;; ########### Treemacs settings ###########
;; #########################################
(global-set-key (kbd "M-0") 'treemacs-select-window)
(global-set-key (kbd "C-x t 1") 'treemacs-delete-other-windows)
(global-set-key (kbd "C-x t t") 'treemacs)
(global-set-key (kbd "C-x t B") 'treemacs-bookmark)
(global-set-key (kbd "C-x t C-t") 'treemacs-find-file)
(global-set-key (kbd "C-x t M-t") 'treemacs-find-tag)

;; #########################################
;; ########## Projectile settings ##########
;; #########################################
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; #########################################
;; ########### Company settings ############
;; #########################################
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))
;; Keybinds allow using tab for autocomplete in helm-company
(define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
(define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 2
      company-dabbrev-downcase nil
      company-dabbrev-other-buffers t
      company-auto-complete nil
      company-dabbrev-code-other-buffers 'all
      company-dabbrev-code-everywhere t
      company-dabbrev-code-ignore-case t)

;; #########################################
;; ########### Theme settings ##############
;; #########################################

(load-theme 'doom-material t)

;; #########################################
;; ######## Modeline settings ##############
;; #########################################

;; (straight-use-package 'mood-line)
(doom-modeline-mode 1)

;; #########################################
;; ####### Disable-mouse settings ##########
;; #########################################
                                        ;(require 'disable-mouse)
                                        ;(global-disable-mouse-mode)

;; #########################################
;; ######### Js2-mode settings #############
;; #########################################
(add-to-list 'auto-mode-alist '("\\.js?\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.ts?\\'" . typescript-mode))

;; #########################################
;; ######### Yaml-mode settings ############
;; #########################################
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Misc

;; (set-face-foreground 'line-number "#9BA3A7")
(good-scroll-mode 1)
;; (setq flycheck-javascript-eslint-executable "eslint_d")
;; #########################################
;; ####### Smartparens-mode settings #######
;; #########################################
(add-hook 'prog-mode-hook #'smartparens-mode)
(setq sp-use-paredit-bindings t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e8df30cd7fb42e56a4efc585540a2e63b0c6eeb9f4dc053373e05d774332fc13" "e19ac4ef0f028f503b1ccafa7c337021834ce0d1a2bca03fcebc1ef635776bea" default))
 '(js-indent-level 2)
 '(warning-suppress-types '(((defvaralias losing-value js2-basic-offset)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
