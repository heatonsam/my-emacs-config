;;; package --- My Emacs Config
;;; Commentary:

;;; Code:

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

;; Window size
;; (when window-system (set-frame-size (selected-frame) 150 200))

;; Custom Functions

(defun save-place-reposition ()
  "Force windows to recenter current line (with saved position)."
  (run-with-timer 0 nil
                  (lambda (buf)
                    (when (buffer-live-p buf)
                      (dolist (win (get-buffer-window-list buf nil t))
                        (with-selected-window win (recenter)))))
                  (current-buffer)))

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
      sentence-end-double-space nil
      gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024)) ; 1mb

(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'horizontal-scroll-bar-mode nil)

(setq-default tab-width 2
              indent-tabs-mode nil)

;; Completely disable the mouse
(dolist (key '([drag-mouse-1] [down-mouse-1] [mouse-1]
               [drag-mouse-2] [down-mouse-2] [mouse-2]
               [drag-mouse-3] [down-mouse-3] [mouse-3]))
  (global-unset-key key))

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

;; Hooks
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode) ; Text wrap
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'find-file-hook 'save-place-reposition t)
(add-hook 'eww-mode-hook 'set-buffer-variable-pitch)
(add-hook 'markdown-mode-hook 'set-buffer-variable-pitch)
(add-hook 'Info-mode-hook 'set-buffer-variable-pitch)

(add-hook 'prog-mode-hook ; Font
          (lambda ()
            (set-face-attribute 'default nil
                                :font "Deja Vu Sans Mono"
                                :height 135)))

;; Font
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "DejaVu Sans 13" :height 140 :weight light)))) ;:weight medium
 '(fixed-pitch ((t (:family "DejaVu Sans Mono 14" :slant normal :weight light :height 150))))) ;:width normal

(defun set-buffer-variable-pitch ()
  "Particular settings for variable-pitch buffers (e.g. org)."
  (interactive)
  (variable-pitch-mode t)
  (setq line-spacing 4)
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-block nil :inherit 'fixed-pitch))

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
(straight-use-package 'writeroom-mode)
(straight-use-package 'ascii-art-to-unicode)
(straight-use-package 'dash)
(straight-use-package 'f)
(straight-use-package 'popup)
(straight-use-package 'async)
(straight-use-package 'helm-core)
(straight-use-package 'writeroom-mode)
(straight-use-package 'writegood-mode)
(straight-use-package 'better-defaults)
(straight-use-package 'helm)
(straight-use-package 'helm-swoop)
(straight-use-package 'flycheck)
(straight-use-package 'expand-region)
(straight-use-package 'avy)
(straight-use-package 'which-key)
(straight-use-package 'multiple-cursors)
(straight-use-package 'restart-emacs)
(straight-use-package 'visual-regexp)
(straight-use-package 'undo-tree)
(straight-use-package 'treemacs)
(straight-use-package 'treemacs-projectile)
(straight-use-package 'treemacs-icons-dired)
(straight-use-package 'treemacs-magit)
(straight-use-package 'projectile)
(straight-use-package 'company)
(straight-use-package 'helm-company)
(straight-use-package 'aggressive-indent)
(straight-use-package 'smartparens)
(straight-use-package 'rainbow-delimiters)
(straight-use-package 'magit)
(straight-use-package 'forge)
(straight-use-package 'magit-todos)
(straight-use-package 'exec-path-from-shell)
(straight-use-package 'solarized-theme)
(straight-use-package 'material-theme)
(straight-use-package 'doom-themes)
(straight-use-package 'darkokai-theme)
(straight-use-package 'mood-one-theme)
(straight-use-package 'atom-one-dark-theme)
(straight-use-package 'doom-modeline)
(straight-use-package 'all-the-icons)
(straight-use-package 'emojify)
(straight-use-package 'disable-mouse)
(straight-use-package 'web-mode)
(straight-use-package 'js2-mode)
(straight-use-package 'yaml-mode)
(straight-use-package 'json-mode)
(straight-use-package 'clojure-mode)
(straight-use-package 'anakondo)
(straight-use-package 'cider)
(straight-use-package 'flycheck-clj-kondo)
(straight-use-package 'sass-mode)
(straight-use-package 'php-mode)
(straight-use-package 'pip-requirements)
(straight-use-package 'docker)
(straight-use-package 'docker-tramp)
(straight-use-package 'company-jedi)
(straight-use-package 'dotenv-mode)
(straight-use-package 'irony)
(straight-use-package 'nginx-mode)
(straight-use-package 'py-autopep8)
(straight-use-package 'yasnippet)
(straight-use-package 'lsp-mode)
(straight-use-package 'lsp-treemacs)
(straight-use-package 'hydra)
(straight-use-package 'company-lsp)
(straight-use-package 'lsp-ui)
(straight-use-package 'lsp-java)
(straight-use-package 'dap-mode)
(straight-use-package 'helm-lsp)
(straight-use-package 'org-bullets)
(straight-use-package 'flycheck-inline)
(straight-use-package 'flycheck-status-emoji)
(straight-use-package 'org-pomodoro)
(straight-use-package 'org-journal)

;; Package settings

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
      helm-swoop-split-with-multiple-windows nil
      ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
      helm-swoop-split-direction 'split-window-vertically
      ;; If nil, you can slightly boost invoke speed in exchange for text color
      helm-swoop-speed-or-color nil
      ;; Go to the opposite side of line from the end or beginning of line
      helm-swoop-move-to-line-cycle t
      ;; Optional face for line numbers
      ;; Face name is `helm-swoop-line-number-face`
      helm-swoop-use-line-number-face t
      ;; If you prefer fuzzy matching
      helm-swoop-use-fuzzy-match t)

;; #########################################
;; ########### Flycheck settings ###########
;; #########################################

(global-flycheck-mode)
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

;; #########################################
;; ########### Writeroom settings ##########
;; #########################################
(add-hook 'journal-mode-hook 'writeroom-mode)
(add-hook 'journal-mode-hook 'writegood-mode)

;; #########################################
;; ############ Avy settings ###############
;; #########################################
(avy-setup-default)

;; #########################################
;; ######## Which-key-mode settings ########
;; #########################################
(which-key-mode)
(which-key-setup-side-window-right-bottom)

;; #########################################
;; ####### Multiple-cursors settings #######
;; #########################################
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; #########################################
;; ######## Visual regexp settings #########
;; #########################################
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
(define-key global-map (kbd "C-c m") 'vr/mc-mark)

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
;; ###### Aggressive-indent settings #######
;; #########################################
(add-hook 'prog-mode-hook #'aggressive-indent-mode)

;; #########################################
;; ####### Smartparens-mode settings #######
;; #########################################
(add-hook 'prog-mode-hook #'smartparens-mode)

;; #########################################
;; ###### Rainbow-delimiters settings ######
;; #########################################
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; #########################################
;; ##### exec-path-from-shell settings #####
;; #########################################
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; #########################################
;; ########### Theme settings ##############
;; #########################################

;; Theme to load on startup
;; (load-theme 'darkokai t)
;; (setq darkokai-mode-line-padding 1) ;; Default mode-line box width
(load-theme 'doom-molokai t)
;; (load-theme 'doom-one)

;; Additional colour tweaks
(set-face-background 'line-number "#242728")
(set-face-foreground 'line-number-current-line "#63de5d")

;; #########################################
;; ######## Modeline settings ##############
;; #########################################

;; (straight-use-package 'mood-line)
(doom-modeline-mode 1)

;; #########################################
;; ########### emojify settings ############
;; #########################################
(add-hook 'after-init-hook #'global-emojify-mode)

;; #########################################
;; ####### Disable-mouse settings ##########
;; #########################################
(require 'disable-mouse)
(global-disable-mouse-mode)

;; #########################################
;; ######### Web-mode settings #############
;; #########################################
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indent."
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; #########################################
;; ######### Js2-mode settings #############
;; #########################################
(add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode))

;; #########################################
;; ######### Yaml-mode settings ############
;; #########################################
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; #########################################
;; ######### Akanondo-mode settings ########
;; #########################################
;; Delays loading of anakondo until a clojure buffer is used
(autoload 'anakondo-minor-mode "anakondo")

;; #########################################
;; ######### Clojure-mode settings #########
;; #########################################
(add-hook 'inf-clojure-mode-hook 'clojure-mode-font-lock-setup)

;; #########################################
;; ######### Cider-mode settings ###########
;; #########################################
(setq nrepl-hide-special-buffers t
      cider-repl-pop-to-buffer-on-connect nil
      cider-popup-stacktraces nil
      cider-repl-popup-stacktraces t)

;; #########################################
;; ##### Flycheck-clj-kondo settings #######
;; #########################################
(require 'flycheck-clj-kondo)

;; #########################################
;; ######## Anakondo-mode settings #########
;; #########################################
;; Enable anakondo-minor-mode in all Clojure buffers
(add-hook 'clojure-mode-hook #'anakondo-minor-mode)
;; Enable anakondo-minor-mode in all ClojureScript buffers
(add-hook 'clojurescript-mode-hook #'anakondo-minor-mode)
;; Enable anakondo-minor-mode in all cljc buffers
(add-hook 'clojurec-mode-hook #'anakondo-minor-mode)

;; #########################################
;; ######### Python-mode settings ##########
;; #########################################
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;; #########################################
;; ########## LSP-mode settings ############
;; #########################################
(add-hook 'prog-mode-hook #'lsp)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; #########################################
;; ######## Yasnippet-mode settings ########
;; #########################################

;; #########################################
;; ######### Flycheck settings #############
;; #########################################
;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))
;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; #########################################
;; ######### Org-mode settings #############
;; #########################################
(defun org-mode-stuff ()
  ;; misc
  ;; (setq left-margin-width 2)
  ;; (setq right-margin-width 2)
  ;; (set-window-buffer nil (current-buffer))
  (writeroom-mode)
  ;; (require 'org-tempo)
  (require 'ob-clojure)
  (require 'ob-java)
  (org-bullets-mode 1)
  (visual-line-mode)
  (org-indent-mode)
  ;; (setq header-line-format " ")
  ;;(variable-pitch-mode 1)
  ;;(setq header-line-format " ")
  ;;
  (local-set-key "\M-n" 'outline-next-visible-heading)
  (local-set-key "\M-p" 'outline-previous-visible-heading)
  ;; table
  (local-set-key "\C-\M-w" 'org-table-copy-region)
  (local-set-key "\C-\M-y" 'org-table-paste-rectangle)
  (local-set-key "\C-\M-l" 'org-table-sort-lines)
  ;; display images
  (local-set-key "\M-I" 'org-toggle-image-in-org)
  ;; fix tab
  (local-set-key "\C-y" 'yank))

(add-hook 'org-mode-hook
          (lambda ()
            (org-mode-stuff)
            (set-buffer-variable-pitch)))

;; Org-mode constants
(setq org-src-tab-acts-natively t
      org-src-fontify-natively t
      org-babel-clojure-backend 'cider
      org-ellipsis "  "
      org-fontify-whole-heading-line t
      org-hide-emphasis-markers t
      org-agenda-block-separator ""
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t
      org-bullets-bullet-list '("⬢" "◆" "▲" "■")
      org-tags-column 0
      org-src-fontify-natively t
      org-edit-src-content-indentation 0
      org-confirm-babel-evaluate nil
      org-src-preserve-indentation t
      org-directory (expand-file-name "~/Documents/org")
      org-agenda-files '("~/Documents/org" "~/Documents/org/html" "~/Documents/org/html/_org")
      org-default-notes-file (concat org-directory "/mygtd.org")
      org-edit-src-content-indentation 0
      org-src-tab-acts-natively t
      org-src-fontify-natively t
      org-fast-tag-selection-single-key t
      org-use-fast-todo-selection t
      org-confirm-babel-evaluate nil
      org-html-htmlize-output-type 'css
      ;; A lot taken from http://www.i3s.unice.fr/~malapert/emacs_orgmode.html
      ;; and https://orgmode.org/worg/org-configs/org-config-examples.html
      org-todo-keywords
      '((sequence "IDEA(i)" "TODO(t)" "STARTED(s)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)")
        (sequence "|" "CANCELED(c)" "DELEGATED(l)" "SOMEDAY(f)"))
      org-todo-keyword-faces
      '(("IDEA" . (:foreground "GoldenRod" :weight bold))
        ("NEXT" . (:foreground "IndianRed1" :weight bold))
        ("STARTED" . (:foreground "OrangeRed" :weight bold))
        ("WAITING" . (:foreground "coral" :weight bold))
        ("CANCELED" . (:foreground "LimeGreen" :weight bold))
        ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
        ("SOMEDAY" . (:foreground "LimeGreen" :weight bold)))
      org-tag-persistent-alist
      '((:startgroup . nil)
        ("HOME" . ?h)
        ("RESEARCH" . ?r)
        ("TEACHING" . ?t)
        (:endgroup . nil)
        (:startgroup . nil)
        ("OS" . ?o)
        ("DEV" . ?d)
        ("WWW" . ?w)
        (:endgroup . nil)
        (:startgroup . nil)
        ("EASY" . ?e)
        ("MEDIUM" . ?m)
        ("HARD" . ?a)
        (:endgroup . nil)
        ("URGENT" . ?u)
        ("KEY" . ?k)
        ("BONUS" . ?b)
        ("noexport" . ?x))
      org-tag-faces
      '(("HOME" . (:foreground "GoldenRod" :weight bold))
        ("RESEARCH" . (:foreground "GoldenRod" :weight bold))
        ("TEACHING" . (:foreground "GoldenRod" :weight bold))
        ("OS" . (:foreground "IndianRed1" :weight bold))
        ("DEV" . (:foreground "IndianRed1" :weight bold))
        ("WWW" . (:foreground "IndianRed1" :weight bold))
        ("URGENT" . (:foreground "Red" :weight bold))
        ("KEY" . (:foreground "Red" :weight bold))
        ("EASY" . (:foreground "OrangeRed" :weight bold))
        ("MEDIUM" . (:foreground "OrangeRed" :weight bold))
        ("HARD" . (:foreground "OrangeRed" :weight bold))
        ("BONUS" . (:foreground "GoldenRod" :weight bold))
        ("noexport" . (:foreground "LimeGreen" :weight bold)))
      org-reverse-note-order t
      org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/mygtd.org" "Tasks")
         "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
        ("i" "Idea" entry (file+headline "~/org/mygtd.org" "Someday/Maybe")
         "* IDEA %?\nAdded: %U\n" :prepend t :kill-buffer t))
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-ascii-headline-spacing (quote (1 . 1))
      org-html-coding-system 'utf-8-unix)

;; Export org-mode files to GitHub Markdown.
(eval-after-load "org"
  '(require 'ox-gfm nil t))

(define-skeleton org-skeleton
  "Header info for a emacs-org file."
  "Title: "
  "#+TITLE:" str " \n"
  "#+AUTHOR: Sam Heaton\n"
                                        ;"#+email: your-email@server.com\n"
  "#+INFOJS_OPT: \n"
  "#+BABEL: :session *R* :cache yes :results output graphics :exports both :tangle yes \n"
  "-----")
(global-set-key [C-S-f4] 'org-skeleton)

;; #########################################
;; ######### Org-babel settings ############
;; #########################################

;; activate specific org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (clojure . t)
   (org . t)
   (shell . t)
   (C . t)
   (java . t)
   (python . t)
   (gnuplot . t)
   (octave . t)
   (R . t)
   (js . t)
   (awk . t)))

;; Unused
;; (straight-use-package 'highlight-thing)
;; (add-hook 'prog-mode-hook 'highlight-thing-mode)
;; (straight-use-package 'highlight-indent-guides)
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;; (setq highlight-indent-guides-method 'column)

;;; emacs-config.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1c1e1f" "#e74c3c" "#b6e63e" "#e2c770" "#268bd2" "#fb2874" "#66d9ef" "#d6d6d4"])
 '(custom-safe-themes
   '("c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "488e77bdde580d8fc5aeecccd882fea86c80d0cb372f1dde2b458e81e328795b" "dff5f62b0ac5e63e0c7f762007d3a430b8cea391afe7a1acb225cafa115f777c" "e1ecb0536abec692b5a5e845067d75273fe36f24d01210bf0aa5842f2a7e029f" "99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "4daff0f7fb02c7a4d5766a6a3e0931474e7c4fd7da58687899485837d6943b78" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" "e47c0abe03e0484ddadf2ae57d32b0f29f0b2ddfe7ec810bd6d558765d9a6a6c" "0fe9f7a04e7a00ad99ecacc875c8ccb4153204e29d3e57e9669691e6ed8340ce" "afe5e2fb3b1e295e11c3c22e7d9ea7288a605c110363673987c8f6d05b1e9972" "7d937147c6dcb7b7693b98cb34af3fa024083c97167e6909c611ddc05b578034" "9d54f3a9cf99c3ffb6ac8e84a89e8ed9b8008286a81ef1dbd48d24ec84efb2f1" "4a9f595fbffd36fe51d5dd3475860ae8c17447272cf35eb31a00f9595c706050" "a7928e99b48819aac3203355cbffac9b825df50d2b3347ceeec1e7f6b592c647" "846ef3695c42d50347884515f98cc359a7a61b82a8d0c168df0f688cf54bf089" "837f2d1e6038d05f29bbcc0dc39dbbc51e5c9a079e8ecd3b6ef09fc0b149ceb1" "dc677c8ebead5c0d6a7ac8a5b109ad57f42e0fe406e4626510e638d36bcc42df" "82b5e8962e15b145fe0c37612ef44b1fec025cf2aa6af31c87d0b37f8b5ae6e0" "32fd809c28baa5813b6ca639e736946579159098d7768af6c68d78ffa32063f4" default))
 '(fci-rule-color "#555556")
 '(horizontal-scroll-bar-mode nil)
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#fd971f"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#b6e63e"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#525254"))
 '(lsp-ui-doc-alignment 'window)
 '(lsp-ui-doc-border "#1c1e1f")
 '(lsp-ui-doc-delay 0.5)
 '(lsp-ui-doc-enable t)
 '(lsp-ui-doc-header t)
 '(lsp-ui-doc-max-height 300)
 '(lsp-ui-doc-position 'top)
 '(lsp-ui-doc-use-childframe t)
 '(lsp-ui-doc-use-webkit nil)
 '(lsp-ui-sideline-delay 0.1)
 '(lsp-ui-sideline-diagnostic-max-line-length 100)
 '(lsp-ui-sideline-diagnostic-max-lines 20)
 '(lsp-ui-sideline-enable nil)
 '(lsp-ui-sideline-ignore-duplicate t)
 '(lsp-ui-sideline-show-code-actions nil)
 '(lsp-ui-sideline-show-diagnostics nil)
 '(lsp-ui-sideline-show-hover t)
 '(lsp-ui-sideline-show-symbol nil)
 '(lsp-ui-sideline-update-mode 'point)
 '(objed-cursor-color "#e74c3c")
 '(org-agenda-files '("~/Documents/org/agenda.org"))
 '(pdf-view-midnight-colors (cons "#d6d6d4" "#1c1e1f"))
 '(scroll-bar-mode nil)
 '(vc-annotate-background "#1c1e1f")
 '(vc-annotate-color-map
   (list
    (cons 20 "#b6e63e")
    (cons 40 "#c4db4e")
    (cons 60 "#d3d15f")
    (cons 80 "#e2c770")
    (cons 100 "#ebb755")
    (cons 120 "#f3a73a")
    (cons 140 "#fd971f")
    (cons 160 "#fc723b")
    (cons 180 "#fb4d57")
    (cons 200 "#fb2874")
    (cons 220 "#f43461")
    (cons 240 "#ed404e")
    (cons 260 "#e74c3c")
    (cons 280 "#c14d41")
    (cons 300 "#9c4f48")
    (cons 320 "#77504e")
    (cons 340 "#555556")
    (cons 360 "#555556")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "DejaVu Sans Mono 13" :slant normal :weight light :height 150))))
 '(lsp-ui-doc-background ((t (:background "#1c1e1f" :foreground "DimGrey" :weight semi-light :width normal))))
 '(lsp-ui-sideline-current-symbol ((t (:foreground "DimGray" :box (:line-width -1 :color "background at point") :weight ultra-bold :height 0.99))))
 '(lsp-ui-sideline-global ((t nil)))
 '(lsp-ui-sideline-symbol-info ((t (:background "background at point" :foreground "DimGrey" :slant italic :height 0.99))))
 '(variable-pitch ((t (:family "DejaVu Sans Mono 13" :height 140 :weight light)))))
