;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     (auto-completion :variables
                      auto-completion-front-end 'company
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-complete-with-key-sequence-delay 0
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-usr-company-box t
                      auto-completion-enable-sort-by-usage t
                      )
                      ;; auto-completion-enable-tabnine t)
     (javascript :variables
                 javascript-indent-level 2
                 lsp-headerline-breadcrumb-enable t
                 javascript-backend 'lsp)
     (typescript :variables
                 typescript-indent-level 2
                 typescript-backend 'lsp
                 lsp-headerline-breadcrumb-enable t
                 typescript-linter 'eslint
                 typescript-fmt-tool 'prettier)
     helm
     (ibuffer :variables
              ibuffer-group-buffers-by 'project)
     ;; better-defaults
     emacs-lisp
     (git)
     (github)
     markdown
     evil-snipe
     lsp
     (org :variables
          org-enable-github-support t
          org-enable-bootstrap-support t
          org-projectile-file "TODOs.org"
          org-enable-epub-support t)
     markdown
     dash
     yaml
     (syntax-checking :variables
                      syntax-checking-enable-tooltips t)
     (json :variables json-fmt-tool 'prettier)
     (shell :variables
             shell-default-height 30
             shell-default-position 'bottom)
     ;; spell-checking
     (react)
     (vue :variables
          web-mode-markup-indent-offset 2
          web-mode-css-indent-offset 2
          web-mode-code-indent-offset 2
          web-mode-attr-indent-offset 2
          lsp-headerline-breadcrumb-enable t
          vue-backend 'lsp)
     (node :variables node-add-modules-path t)
     version-control
     (treemacs :variables
               treemacs-use-filewatch-mode t
               treemacs-use-follow-mode t
               treemacs-use-scope-type 'Perspectives
               treemacs-use-git-mode 'extended)
     (wakatime :variables
               ;; use the actual wakatime path
               wakatime-cli-path "/usr/local/bin/wakatime")
    )
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
     nyan-mode
     drag-stuff
     magit-delta
     evil-smartparens
     beacon
     helm-icons
     rg
     carbon-now-sh
     dimmer
     ;; quelpa
     ;; company-tabnine
     ;; company-quickhelp
   )
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '()
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(spacemacs-dark
                         solarized-light
                         solarized-dark
                         leuven
                         gruvbox
                         dichromacy
                         flatui
                         darktooth
                         monokai
                         zenburn
                         spacemacs-light)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Source Code Pro"
                               :size 14
                               :weight normal
                               :width normal
                               :powerline-offset 2
                               :powerline-scale 1.5)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ nil
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts t
   dotspacemacs-large-file-size 1
   dotspacemacs-active-transparency 100
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers 'relative
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis t
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'tailing
   ))

(defun dotspacemacs/user-init ()
  ;; load shell config file custom function
  (defun er-find-shell-init-file ()
    "Edit the shell init file in another window"
    (interactive)
    (let* ((shell (car (reverse (split-string (getenv "SHELL") "/"))))
           (shell-init-file (cond
                             ((string-equal "zsh" shell) ".zshrc")
                             ((string-equal "bash" shell) ".bashrc")
                             (t (error "Unkown shell")))))
      (find-file-other-window (expand-file-name shell-init-file (getenv "HOME")))))

  ;; save/read windows layout
  ;; 구글링을 한 끝에 찾아낸 유용한 함수들
  ;; 이하의 함수들은 이맥스가 시작하고 종료될때 훅으로 실행되도록
  ;; general.el파일에 설정이 들어가 있다.
  (defun save-framegeometry ()
    "Gets the current frame's geometry and saves to ~/.emacs.d/framegeometry."
    (let (
          (framegeometry-left (frame-parameter (selected-frame) 'left))
          (framegeometry-top (frame-parameter (selected-frame) 'top))
          (framegeometry-width (frame-parameter (selected-frame) 'width))
          (framegeometry-height (frame-parameter (selected-frame) 'height))
          (framegeometry-file (expand-file-name "~/.emacs.d/framegeometry"))
          )

      (when (not (number-or-marker-p framegeometry-left))
        (setq framegeometry-left 0))
      (when (not (number-or-marker-p framegeometry-top))
        (setq framegeometry-top 0))
      (when (not (number-or-marker-p framegeometry-width))
        (setq framegeometry-width 0))
      (when (not (number-or-marker-p framegeometry-height))
        (setq framegeometry-height 0))

      (with-temp-buffer
        (insert
         ";;; This is the previous emacs frame's geometry.\n"
         ";;; Last generated " (current-time-string) ".\n"
         "(setq initial-frame-alist\n"
         "      '(\n"
         (format "        (top . %d)\n" (max framegeometry-top 0))
         (format "        (left . %d)\n" (max framegeometry-left 0))
         (format "        (width . %d)\n" (max framegeometry-width 0))
         (format "        (height . %d)))\n" (max framegeometry-height 0)))
         (when (file-writable-p framegeometry-file)
         (write-file framegeometry-file))))
  )

  (defun load-framegeometry ()
    (let ((framegeometry-file (expand-file-name "~/.emacs.d/framegeometry")))
      (when (file-readable-p framegeometry-file)
        (message "Load frame geometry from file")
        (load-file framegeometry-file)))
  )
  )

(defun dotspacemacs/user-config ()
  ;; for emacsclient
  (setq scroll-bar-mode nil)
  ;; (setq ns-use-srgb-colorspace nil)
  (spacemacs/load-theme 'spacemacs-dark)
  ;; setup my profile
  (setq user-full-name "Jaejin Park")
  (setq user-mail-address "jjpark78@outlook.com")

  ;;이맥스 종료할때 그냥 묻지도 따지지도 말고 종료하도록 했다.
  (setq confirm-kill-processes nil)
  (setq confirm-kill-emacs nil)

  ;; make support CamelCase Syntax
  (global-subword-mode 1)

  (spacemacs|do-after-display-system-init
   (setq powerline-default-separator 'slant))

  ;; display time globally
  (spaceline-define-segment datetime
    (shell-command-to-string "echo -n $(date +'%Y-%m-%d %a %T')"))
  (spaceline-spacemacs-theme 'datetime)
  ;; load previous window position
  ;; Restore Frame size and location, if we are using gui emacs
  (add-hook 'after-init-hook 'load-framegeometry)
  (add-hook 'kill-emacs-hook 'save-framegeometry)

  ;; setup lsp fine tune
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.500)

  ;;iedit bug
  ;;need to wait for https://github.com/syl20bnr/evil-iedit-state/issues/27 releases
  (defalias 'iedit-cleanup 'iedit-lib-cleanup)

  ;; use indent-guide globally
  ;; (spacemacs/toggle-indent-guide-globally-on)

  ;; disable indent-guide in visual mode
  ;; (add-hook 'evil-visual-state-entry-hook #'spacemacs/toggle-indent-guide-off)
  ;; (add-hook 'evil-visual-state-exit-hook #'spacemacs/toggle-indent-guide-on)

  ;;line number style
  (setq-default
   display-line-numbers-width 5
   display-line-numbers-width-start 5
   )

  ;; Show quick tooltip
  ;; (use-package company-quickhelp
  ;;   :defines company-quickhelp-delay
  ;;   :bind (:map company-active-map
  ;;               ("M-h" . company-quickhelp-manual-begin))
  ;;   :hook (global-company-mode . company-quickhelp-mode)
  ;;   :custom (company-quickhelp-delay 0.8))

  ;; config evil-smartparens package
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)

  ;; nyan-mode
  (nyan-mode)
  (nyan-start-animation)

  ;; add icons to helm
  (helm-icons-enable)
  (treemacs-resize-icons 16)

  ;; flycheck setup
  ;; (global-flycheck-mode)

  ;; Keep file in sync
  (global-auto-revert-mode 1)

  ;; dimmer config
  (dimmer-mode t)
  (setq dimmer-fraction 0.1)

  ;; misc config
  (setq global-auto-revert-non-file-buffers t)
  (setq auto-revert-verbose nil)
  (setq revert-without-query '(".*"))
  (setq tab-always-indent t)
  (setq auth-sources '("~/.config/authrc"))

  ;;make spaceline more lighten
  (with-eval-after-load 'spaceline-segments
    (spaceline-toggle-anzu-off)
    (spaceline-toggle-battery-off)
    (spaceline-toggle-buffer-position-on)
    (spaceline-toggle-point-position-on)
    (spaceline-toggle-persp-name-off)
    (spaceline-toggle-all-the-icons-vc-status-on)
    (spaceline-toggle-all-the-icons-git-status-on)
    (spaceline-toggle-all-the-icons-vc-icon-on)
    (spaceline-toggle-minor-modes-off)
    (spaceline-toggle-buffer-size-off))

  ;; let diff to delta mode
  (magit-delta-mode)

  ;; powerline seperator
  (setq dotspacemacs-mode-line-theme '(all-the-icons :separator 'slant))

  ;; activate beacon
  (beacon-mode 1)

  ;; setup korean
  (set-language-environment "Korean")
  (prefer-coding-system 'utf-8)

  ;; only use magit
  (setq vc-handled-backends nil)

  ;; vc, magit config
  (setq vc-follow-symlinks t)
  (setq find-file-visit-truename t)
  (setq magit-refresh-status-buffer 'switch-to-buffer)
  (setq magit-rewrite-inclusive 'ask)
  (setq magit-save-some-buffers t)
  (setq magit-set-upstream-on-push 'askifnotset)

  ;; rg setup
  (setq rg-group-result t)
  (setq rg-hide-command t)
  (setq rg-show-columns nil)
  (setq rg-show-header t)
  (setq rg-custom-type-aliases nil)
  (setq rg-default-alias-fallback "all")

  ;; my key binding
  ;; not working
  ;; (setq-default evil-escape-key-sequence "jj")

  ;; surround binding
  (evil-define-key 'visual evil-surround-mode-map "s" 'evil-substitute)
  (evil-define-key 'visual evil-surround-mode-map "S" 'evil-surround-region)

  ;; line move binding
  (global-set-key (kbd "C-S-k") 'drag-stuff-up)
  (global-set-key (kbd "C-S-j") 'drag-stuff-down)

  ;; buffer list
  ;; doom emacs style
  (spacemacs/set-leader-keys "," 'helm-projectile-switch-to-buffer)
  ;; for emacsclient and daemon mode

  (spacemacs/set-leader-keys "qq" 'spacemacs/frame-killer)
  (spacemacs/set-leader-keys "," 'helm-projectile-switch-to-buffer)
  ;; move line head, end faster
  (evil-global-set-key 'normal "H" 'evil-first-non-blank)
  (evil-global-set-key 'visual "H" 'evil-first-non-blank)
  (evil-global-set-key 'motion "H" 'evil-first-non-blank)
  (evil-global-set-key 'normal "L" (lambda () (interactive) (evil-end-of-line)))
  (evil-global-set-key 'visual "L" (lambda () (interactive) (evil-end-of-line)))
  (evil-global-set-key 'motion "L" (lambda () (interactive) (evil-end-of-line)))

  ;; jump to position faster
  (define-key evil-motion-state-map "gl" 'evil-avy-goto-line)
  (define-key evil-normal-state-map "gl" 'evil-avy-goto-line)
  (define-key evil-motion-state-map "gw" 'evil-avy-goto-char-2)
  (define-key evil-normal-state-map "gw" 'evil-avy-goto-char-2)
  (define-key evil-normal-state-map "gr" 'lsp-ui-peek-find-references)
  (define-key evil-normal-state-map "gb" 'evil-jump-backward)

  ;; add dired move subdirectory
  ;; (with-eval-after-load 'dired
  ;;   (evil-define-key 'normal dired-mode-map
  ;;     "h" 'dired-up-directory
  ;;     "l" 'dired-find-file))

  ;; setup rg binding
  (spacemacs/set-leader-keys "rg" 'rg-project)

  ;; setup edit shell config file shortcut
  (spacemacs/set-leader-keys "fz" 'er-find-shell-init-file)

  ;; setup carbon now sh binding
  (spacemacs/set-leader-keys "cB" 'carbon-now-sh)

  ;; setup wakatime api key
  (load "~/.config/spacemacs/wakatime")

  ;; setup centaur tab
  ;; (use-package centaur-tabs
  ;;   :ensure t
  ;;   :demand
  ;;   :config
  ;;   (centaur-tabs-mode t)
  ;;   )
  ;; (global-set-key (kbd "gt")  'centaur-tabs-forward)
  ;; (global-set-key (kbd "gT")  'centaur-tabs-backward)
  )

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(package-selected-packages
   '(zenburn-theme zen-and-art-theme white-sand-theme web-mode underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme tagedit sunny-day-theme sublime-themes subatomic256-theme subatomic-theme spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme slim-mode seti-theme scss-mode sass-mode reverse-theme rebecca-theme railscasts-theme purple-haze-theme pug-mode professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme organic-green-theme omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme naquadah-theme mustang-theme monokai-theme monochrome-theme molokai-theme moe-theme modus-vivendi-theme modus-operandi-theme minimal-theme material-theme majapahit-theme madhat2r-theme lush-theme light-soap-theme kaolin-themes jbeans-theme jazz-theme ir-black-theme inkpot-theme impatient-mode htmlize heroku-theme hemisu-theme helm-css-scss hc-zenburn-theme haml-mode gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gandalf-theme flatui-theme flatland-theme farmhouse-theme eziam-theme exotica-theme espresso-theme emmet-mode dracula-theme doom-themes django-theme darktooth-theme darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme company-web web-completion-data color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme chocolate-theme autothemer cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme add-node-modules-path lsp-mode ht dash-functional tide typescript-mode flycheck xterm-color web-beautify vue-mode edit-indirect ssass-mode vue-html-mode smeargle shell-pop orgit multi-term mmm-mode markdown-toc markdown-mode magit-gitflow magit-popup livid-mode skewer-mode simple-httpd json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc helm-gitignore helm-company helm-c-yasnippet gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md fuzzy evil-magit magit git-commit with-editor transient eshell-z eshell-prompt-extras esh-help diff-hl company-statistics company coffee-mode auto-yasnippet yasnippet ac-ispell auto-complete ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hydra lv hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-projectile projectile pkg-info epl helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired f evil-tutor evil-surround evil-search-highlight-persist highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu elisp-slime-nav dumb-jump dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async))
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-selection ((t (:extend t :background "VioletRed4" :foreground "gray100" :inverse-video nil)))))
)
