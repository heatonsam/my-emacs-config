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

;; Backups
(setq backup-directory-alist '(("." . "~/.config/emacs/backups")))

;; Autosaving, Backups
(setq delete-old-versions t)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.config/emacs/auto-save-list/" t)))

;; File History
(setq savehist-file "~/.config/emacs/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; Encoding
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)
(setq coding-system-for-write 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))

;; Window size
(when window-system (set-frame-size (selected-frame) 100 30))

;; Unbind Pesky Sleep Button


;; Enable text wrap
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;; Clean up whitespace
;;(bind-key "M-SPC" 'cycle-spacing)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Misc visual/workspace changes
(save-place-mode 1)

(defun save-place-reposition ()
  "Force windows to recenter current line (with saved position)."
  (run-with-timer 0 nil
                  (lambda (buf)
                    (when (buffer-live-p buf)
                      (dolist (win (get-buffer-window-list buf nil t))
                        (with-selected-window win (recenter)))))
                  (current-buffer)))

(add-hook 'find-file-hook 'save-place-reposition t)

(setq inhibit-startup-screen t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq c-basic-offset 2)

(setq indent-line-function 'insert-tab)

(setq sentence-end-double-space nil)
; (setq-default show-trailing-whitespace t) ; No need to show if it is deleted with each save.

(setq inhibit-compacting-font-caches t)

(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'horizontal-scroll-bar-mode nil)


(fringe-mode 0)
(fset 'yes-or-no-p 'y-or-n-p)
(column-number-mode 1)
(delete-selection-mode 1)
(global-subword-mode 1)
(show-paren-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(global-visual-line-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(straight-use-package 'writeroom-mode)
(straight-use-package 'ascii-art-to-unicode)
(setq ring-bell-function 'ignore)

;; APIs
(straight-use-package 'dash)
(straight-use-package 'f)
(straight-use-package 'popup)
(straight-use-package 'async)
(straight-use-package 'helm-core)

;; Fonts

;;; Fira code

;; (when (window-system)
;;   (set-frame-font "Fira Mono-13"))
;; (defun fira-code-mode--make-alist (list)
;;   "Generate prettify-symbols alist from LIST."
;;   (let ((idx -1))
;;     (mapcar
;;      (lambda (s)
;;        (setq idx (1+ idx))
;;        (let* ((code (+ #Xe100 idx))
;;               (width (string-width s))
;;               (prefix ())
;;               (suffix '(?\s (Br . Br)))
;;               (n 1))
;;          (while (< n width)
;;            (setq prefix (append prefix '(?\s (Br . Bl))))
;;            (setq n (1+ n)))
;;          (cons s (append prefix suffix (list (decode-char 'ucs code))))))
;;      list)))

;; (defconst fira-code-mode--ligatures
;;   '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
;;     "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
;;     "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
;;     "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
;;     ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
;;     "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
;;     "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
;;     "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
;;     ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
;;     "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
;;     "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
;;     "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
;;     "x" ":" "+" "+" "*"))

;; (defvar fira-code-mode--old-prettify-alist)

;; (defun fira-code-mode--enable ()
;;   "Enable Fira Code ligatures in current buffer."
;;   (setq-local fira-code-mode--old-prettify-alist prettify-symbols-alist)
;;   (setq-local prettify-symbols-alist (append (fira-code-mode--make-alist fira-code-mode--ligatures) fira-code-mode--old-prettify-alist))
;;   (prettify-symbols-mode t))

;; (defun fira-code-mode--disable ()
;;   "Disable Fira Code ligatures in current buffer."
;;   (setq-local prettify-symbols-alist fira-code-mode--old-prettify-alist)
;;   (prettify-symbols-mode -1))

;; (define-minor-mode fira-code-mode
;;   "Fira Code ligatures minor mode"
;;   :lighter " Fira Code"
;;   (setq-local prettify-symbols-unprettify-at-point 'right-edge)
;;   (if fira-code-mode
;;       (fira-code-mode--enable)
;;     (fira-code-mode--disable)))

;; (defun fira-code-mode--setup ()
;;   "Setup Fira Code Symbols."
;;   (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol"))

;; (provide 'fira-code-mode)
;; (add-hook 'prog-mode-hook 'fira-code-mode);;; Fira code

;; Package installation

;; Core

(straight-use-package 'better-defaults)

(straight-use-package 'helm)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)
(add-hook 'helm-major-mode-hook
          (lambda ()
            (setq auto-composition-mode nil)))

(straight-use-package 'helm-swoop)

;; Helm swoop
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
    (helm-next-line)
    ))

;; C-s in a buffer: open helm-swoop with empty search field
(global-set-key (kbd "C-r") 'helm-swoop)
(with-eval-after-load 'helm-swoop
  (setq helm-swoop-pre-input-function
        (lambda () nil)))

;; C-s in helm-swoop with empty search field: activate previous search.
;; C-s in helm-swoop with non-empty search field: go to next match.
(with-eval-after-load 'helm-swoop
  (define-key helm-swoop-map (kbd "C-r") 'tl/helm-swoop-C-r))

(defun tl/helm-swoop-C-r ()
  (interactive)
  (if (boundp 'helm-swoop-pattern)
      (if (equal helm-swoop-pattern "")
          (previous-history-element 1)
        (helm-previous-line))
    (helm-previous-line)
    ))

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
(define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

;; Move up and down like isearch
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

;; ;; Go to the opposite side of line from the end or beginning of line
(setq helm-swoop-move-to-line-cycle t)

;; Optional face for line numbers
;; Face name is `helm-swoop-line-number-face`
(setq helm-swoop-use-line-number-face t)

;; If you prefer fuzzy matching
(setq helm-swoop-use-fuzzy-match t)

(straight-use-package 'flycheck)
(global-flycheck-mode)
(straight-use-package 'flycheck-inline)
(straight-use-package 'flycheck-status-emoji)
(with-eval-after-load 'flycheck
 (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

;; Writeroom-mode
(straight-use-package 'writeroom-mode)
(straight-use-package 'writegood-mode)

(add-hook 'journal-mode-hook 'writeroom-mode)
(add-hook 'journal-mode-hook 'writegood-mode)

(straight-use-package 'expand-region)

(straight-use-package 'avy)
(avy-setup-default)

(straight-use-package 'which-key)
(which-key-mode)
(which-key-setup-side-window-right-bottom)

;; (straight-use-package 'highlight-thing)
;; (add-hook 'prog-mode-hook 'highlight-thing-mode)

(straight-use-package 'multiple-cursors)
(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(straight-use-package 'restart-emacs)

(straight-use-package 'smooth-scrolling)
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(straight-use-package 'visual-regexp)
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
(define-key global-map (kbd "C-c m") 'vr/mc-mark)

;; Package management
(straight-use-package 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

;; Undo
(straight-use-package 'undo-tree)
(global-undo-tree-mode)

;; Navigation
(straight-use-package 'treemacs)
(straight-use-package 'treemacs-projectile)
(straight-use-package 'treemacs-icons-dired)
(straight-use-package 'treemacs-magit)
(global-set-key (kbd "M-0") 'treemacs-select-window)
(global-set-key (kbd "C-x t 1") 'treemacs-delete-other-windows)
(global-set-key (kbd "C-x t t") 'treemacs)
(global-set-key (kbd "C-x t B") 'treemacs-bookmark)
(global-set-key (kbd "C-x t C-t") 'treemacs-find-file)
(global-set-key (kbd "C-x t M-t") 'treemacs-find-tag)

;; Projects
(straight-use-package 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Completion
(straight-use-package 'company)
(add-hook 'after-init-hook 'global-company-mode)

(straight-use-package 'helm-company)
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))

(define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
(define-key helm-map (kbd "<tab>") #'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") #'helm-select-action)

;; Indentation
(straight-use-package 'aggressive-indent)
;; (add-hook 'prog-mode-hook #'aggressive-indent-mode)

;;(straight-use-package 'highlight-indent-guides)
;;(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;;(setq highlight-indent-guides-method 'column)

;; Parentheses
(straight-use-package 'smartparens)
(add-hook 'prog-mode-hook #'smartparens-mode)
(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Git
(straight-use-package 'magit)
(straight-use-package 'forge)
(straight-use-package 'magit-todos)

;; exec-path-from-shell
(straight-use-package 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Themes
(straight-use-package 'zenburn-theme)
(straight-use-package 'solarized-theme)
(straight-use-package 'color-theme-sanityinc-tomorrow)
(straight-use-package 'monokai-theme)
(straight-use-package 'material-theme)
(straight-use-package 'doom-themes)
(straight-use-package 'monokai-theme)
(straight-use-package 'tangotango-theme)
(straight-use-package 'darkokai-theme)
(straight-use-package 'kaolin-themes)
(straight-use-package 'zerodark-theme)
(straight-use-package 'mood-one-theme)
(straight-use-package 'ewal-spacemacs-themes)
(straight-use-package 'chocolate-theme)
(straight-use-package 'atom-one-dark-theme)
(straight-use-package 'dakrone-theme)


;; Theme to load on startup
(setq darkokai-mode-line-padding 1) ;; Default mode-line box width
(load-theme 'darkokai t)
;(load-theme 'doom-molokai t)
;(load-theme 'doom-one)

;; Modelines
;;(straight-use-package 'spaceline)
;;(straight-use-package 'spaceline-all-the-icons)
(straight-use-package 'doom-modeline)
;; (straight-use-package 'mood-line)

;; Modeline to load on startup
;; (require 'doom-modeline)
(doom-modeline-mode 1)

(flymake-mode 0)

;;(require 'spaceline-all-the-icons)
;;(use-package spaceline-all-the-icons
;;  :after spaceline
;;  :config (spaceline-all-the-icons-theme))

;; Icons
(straight-use-package 'all-the-icons)
(straight-use-package 'emojify)
(add-hook 'after-init-hook #'global-emojify-mode)

;; Language-specific
(straight-use-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(straight-use-package 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode))
(straight-use-package 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(straight-use-package 'vue-mode)

(straight-use-package 'json-mode)

;; Clojure
(straight-use-package 'clojure-mode)
(straight-use-package 'cider)
(setq nrepl-hide-special-buffers t
      cider-repl-pop-to-buffer-on-connect nil
      cider-popup-stacktraces nil
      cider-repl-popup-stacktraces t)

(straight-use-package 'flycheck-clj-kondo)
(require 'flycheck-clj-kondo)

(setq company-idle-delay 0.2)
             (setq company-minimum-prefix-length 2)
             (setq company-dabbrev-downcase nil)
             (setq company-dabbrev-other-buffers t)
                             (setq company-auto-complete nil)
             (setq company-dabbrev-code-other-buffers 'all)
             (setq company-dabbrev-code-everywhere t)
             (setq company-dabbrev-code-ignore-case t)

;; Sass Mode
(straight-use-package 'sass-mode)

;; PHP
(straight-use-package 'php-mode)

(straight-use-package 'pip-requirements)
(straight-use-package 'docker)
(straight-use-package 'docker-tramp)
(straight-use-package 'company-jedi)
(straight-use-package 'dotenv-mode)
(straight-use-package 'irony)
(straight-use-package 'nginx-mode)
(straight-use-package 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;; LSP (Requires more configuration)
(straight-use-package 'yasnippet)
;;(require 'yasnippet)
;;(yas-global-mode 1)
(straight-use-package 'lsp-mode)
;; LSP-MODE settings
(straight-use-package 'lsp-treemacs)
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;(require 'lsp-ui-flycheck)
;(with-eval-after-load 'lsp-mode
;   (add-hook 'lsp-after-open-hook (lambda () (lsp-ui-flycheck-enable 1))))

;; Flycheck config
;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))
;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indent."
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

(straight-use-package 'hydra)
(straight-use-package 'company-lsp)
(straight-use-package 'lsp-ui)
(straight-use-package 'lsp-java)
(straight-use-package 'dap-mode)
(straight-use-package 'helm-lsp)
(add-hook 'prog-mode-hook #'lsp)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; Fonts

(defun prog-mode-fonts-hook ()
  (set-face-attribute 'default nil
                      :font "Hack"
                      :height 135))

(add-hook 'prog-mode-hook #'prog-mode-fonts-hook)

;; Org mode
(straight-use-package 'org-bullets)
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

(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "DejaVu Sans Mono 13" :height 140 :weight light)))) ;:weight medium
 '(fixed-pitch ((t (:family "DejaVu Sans Mono 13" :slant normal :weight light :height 150))))) ;:width normal

  (defun set-buffer-variable-pitch ()
    (interactive)
    (variable-pitch-mode t)
    (setq line-spacing 4)
    (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
    ;; (auto-complete-mode -1)
    ;; (set-face-attribute 'org-block-background nil :inherit 'fixed-pitch)
    )

(add-hook 'org-mode-hook
(lambda ()
  (org-mode-stuff)
  (set-buffer-variable-pitch)))

  (add-hook 'eww-mode-hook 'set-buffer-variable-pitch)
  (add-hook 'markdown-mode-hook 'set-buffer-variable-pitch)
  (add-hook 'Info-mode-hook 'set-buffer-variable-pitch)

(setq org-src-fontify-natively t)
(setq org-babel-clojure-backend 'cider)
;(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(setq org-ellipsis "  ")
(setq org-hide-emphasis-markers t)
(setq org-fontify-whole-heading-line t)
(setq org-agenda-block-separator "")
(setq org-fontify-done-headline t)
(setq org-fontify-quote-and-verse-blocks t)
(setq org-bullets-bullet-list '("⬢" "◆" "▲" "■"))
(setq org-tags-column 0)
(setq org-src-fontify-natively t)
(setq org-edit-src-content-indentation 0)
(setq org-src-tab-acts-natively t)
(setq org-confirm-babel-evaluate nil)
(setq org-src-preserve-indentation t)

(straight-use-package 'org-pomodoro)
(setq org-directory (expand-file-name "~/Documents/org"))
(setq org-default-notes-file (concat org-directory "/mygtd.org"))
(setq org-agenda-files '("~/Documents/org" "~/Documents/org/html" "~/Documents/org/html/_org"))
(setq org-edit-src-content-indentation 0
      org-src-tab-acts-natively t
      org-src-fontify-natively t
      org-confirm-babel-evaluate nil)

;; A lot taken from http://www.i3s.unice.fr/~malapert/emacs_orgmode.html
; and https://orgmode.org/worg/org-configs/org-config-examples.html

(setq org-todo-keywords
      '(
        (sequence "IDEA(i)" "TODO(t)" "STARTED(s)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)")
        (sequence "|" "CANCELED(c)" "DELEGATED(l)" "SOMEDAY(f)")
        ))

(setq org-todo-keyword-faces
      '(("IDEA" . (:foreground "GoldenRod" :weight bold))
        ("NEXT" . (:foreground "IndianRed1" :weight bold))
        ("STARTED" . (:foreground "OrangeRed" :weight bold))
        ("WAITING" . (:foreground "coral" :weight bold))
        ("CANCELED" . (:foreground "LimeGreen" :weight bold))
        ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
        ("SOMEDAY" . (:foreground "LimeGreen" :weight bold))
        ))

(setq org-tag-persistent-alist
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
        ("noexport" . ?x)
        )
      )

(setq org-tag-faces
      '(
        ("HOME" . (:foreground "GoldenRod" :weight bold))
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
        ("noexport" . (:foreground "LimeGreen" :weight bold))
        )
      )

;; Don't know what this does yet search the variables
(setq org-fast-tag-selection-single-key t)
(setq org-use-fast-todo-selection t)

;; Template for linking to files basically?
(setq org-reverse-note-order t)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/mygtd.org" "Tasks")
         "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
        ("i" "Idea" entry (file+headline "~/org/mygtd.org" "Someday/Maybe")
         "* IDEA %?\nAdded: %U\n" :prepend t :kill-buffer t)
        )
      )

(setq org-html-htmlize-output-type 'css)

(define-skeleton org-skeleton
  "Header info for a emacs-org file."
  "Title: "
  "#+TITLE:" str " \n"
  "#+AUTHOR: Sam Heaton\n"
  ;"#+email: your-email@server.com\n"
  "#+INFOJS_OPT: \n"
  "#+BABEL: :session *R* :cache yes :results output graphics :exports both :tangle yes \n"
  "-----"
 )
(global-set-key [C-S-f4] 'org-skeleton)

(add-hook 'inf-clojure-mode-hook 'clojure-mode-font-lock-setup)

; activate specific org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
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
   (awk . t)
   ))

;; ???
;(setq ns-use-thin-smoothing t)

;; Not quite sure
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

; Adjust the number of blank lines inserted around headlines
(setq org-ascii-headline-spacing (quote (1 . 1)))

(eval-after-load "org"
  '(require 'ox-gfm nil t))
(setq org-html-coding-system 'utf-8-unix)

;; ;; GLOBAL Keybindings that can be added to .emacs
;; (global-set-key [f4] 'org-capture)
;; (global-set-key [f5] '(lambda () (interactive)(find-file "~/org/mygtd.org")))
;; (global-set-key [f6] 'org-todo-list)
;; ;; (global-set-key [f7] 'org-agenda)


;; (setq org-capture-templates
;;       '(("c" "Cookbook" entry (file "~/org/cookbook.org")
;;          "%(org-chef-get-recipe-from-url)"
;;          :empty-lines 1)
;;         ("m" "Manual Cookbook" entry (file "~/org/cookbook.org")
;;          "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")))

;; (straight-use-package 'org-brain)
;; (setq org-brain-path "~/Documents/org")

;; (defun org-brain-settings
;; 		"Misc settings."
;; 	(setq org-id-track-globally t)
;; 	(setq org-id-locations-file "~/.emacs.d/.org-id-locations")
;; 	(push '("b" "Brain" plain (function org-brain-goto-end)
;; 					"* %i%?" :empty-lines 1)
;; 				org-capture-templates)
;; 	(setq org-brain-visualize-default-choices 'all)
;; 	(setq org-brain-title-max-length 12)
;; 	(setq org-brain-include-file-entries nil
;; 				org-brain-file-entries-use-title nil))

;; (add-hook 'org-brain-settings-hook #'org-brain-mode)

;; (defface aa2u-face '((t . nil))
;;   "Face for aa2u box drawing characters")
;; (advice-add #'aa2u-1c :filter-return
;;             (lambda (str) (propertize str 'face 'aa2u-face)))
;; (defun aa2u-org-brain-buffer ()
;;   (let ((inhibit-read-only t))
;;     (make-local-variable 'face-remapping-alist)
;;     (add-to-list 'face-remapping-alist
;;                  '(aa2u-face . org-brain-wires))
;;     (ignore-errors (aa2u (point-min) (point-max)))))
;; (with-eval-after-load 'org-brain
;;   (add-hook 'org-brain-after-visualize-hook #'aa2u-org-brain-buffer))

;; (defun org-brain-insert-resource-icon (link)
;;   "Insert an icon, based on content of 'org-mode' LINK."
;;   (insert (format "%s "
;;                   (cond ((string-prefix-p "brain:" link)
;;                          (all-the-icons-fileicon "brain"))
;;                         ((string-prefix-p "info:" link)
;;                          (all-the-icons-octicon "info"))
;;                         ((string-prefix-p "help:" link)
;;                          (all-the-icons-material "help"))
;;                         ((string-prefix-p "http" link)
;;                          (all-the-icons-icon-for-url link))
;;                         (t
;;                          (all-the-icons-icon-for-file link))))))

;; (add-hook 'org-brain-after-resource-button-functions #'org-brain-insert-resource-icon)

;; (setq org-agenda-category-icon-alist
;;       `(("computers" ,(list (all-the-icons-material "computer")) nil nil :ascent center)
;;         ("books" ,(list (all-the-icons-faicon "book")) nil nil :ascent center)))

(straight-use-package 'org-journal)

(set-face-background 'line-number "#242728")
(set-face-foreground 'line-number-current-line "#63de5d")

;; Experimental - styling company autocomplete

;;; emacs-config.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1c1e1f" "#e74c3c" "#b6e63e" "#e2c770" "#268bd2" "#fb2874" "#66d9ef" "#d6d6d4"])
 '(custom-safe-themes
   '("e1ecb0536abec692b5a5e845067d75273fe36f24d01210bf0aa5842f2a7e029f" "99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "4daff0f7fb02c7a4d5766a6a3e0931474e7c4fd7da58687899485837d6943b78" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" "e47c0abe03e0484ddadf2ae57d32b0f29f0b2ddfe7ec810bd6d558765d9a6a6c" "0fe9f7a04e7a00ad99ecacc875c8ccb4153204e29d3e57e9669691e6ed8340ce" "afe5e2fb3b1e295e11c3c22e7d9ea7288a605c110363673987c8f6d05b1e9972" "7d937147c6dcb7b7693b98cb34af3fa024083c97167e6909c611ddc05b578034" "9d54f3a9cf99c3ffb6ac8e84a89e8ed9b8008286a81ef1dbd48d24ec84efb2f1" "4a9f595fbffd36fe51d5dd3475860ae8c17447272cf35eb31a00f9595c706050" "a7928e99b48819aac3203355cbffac9b825df50d2b3347ceeec1e7f6b592c647" "846ef3695c42d50347884515f98cc359a7a61b82a8d0c168df0f688cf54bf089" "837f2d1e6038d05f29bbcc0dc39dbbc51e5c9a079e8ecd3b6ef09fc0b149ceb1" "dc677c8ebead5c0d6a7ac8a5b109ad57f42e0fe406e4626510e638d36bcc42df" "82b5e8962e15b145fe0c37612ef44b1fec025cf2aa6af31c87d0b37f8b5ae6e0" "32fd809c28baa5813b6ca639e736946579159098d7768af6c68d78ffa32063f4" default))
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
 '(fixed-pitch ((t (:family "Hack" :slant normal :weight light :height 135 :width normal))))
 '(lsp-ui-doc-background ((t (:background "#1c1e1f" :foreground "DimGrey" :weight semi-light :width normal))))
 '(lsp-ui-sideline-current-symbol ((t (:foreground "DimGray" :box (:line-width -1 :color "background at point") :weight ultra-bold :height 0.99))))
 '(lsp-ui-sideline-global ((t nil)))
 '(lsp-ui-sideline-symbol-info ((t (:background "background at point" :foreground "DimGrey" :slant italic :height 0.99))))
 '(variable-pitch ((t (:family "Montserrat" :height 160)))))
