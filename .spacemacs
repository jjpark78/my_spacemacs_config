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
                      auto-completion-enable-sort-by-usage t)
                      ;; auto-completion-enable-tabnine t)
     (javascript :variables
                 javascript-indent-level 2
                 javascript-backend 'lsp)
     (typescript :variables
                 typescript-indent-level 2
                 typescript-backend 'lsp
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
          vue-backend 'lsp)
     (node :variables node-add-modules-path t)
     themes-megapack
     version-control
     themes-megapack
     (treemacs :variables
               treemacs-use-filewatch-mode t
               treemacs-use-follow-mode t
               treemacs-use-scope-type 'Perspectives
               treemacs-use-git-mode 'extended)
     (wakatime :variables
               wakatime-api-key  "c6ba049d-8360-45fd-8317-a4b25d0ab860"
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
  )

(defun dotspacemacs/user-config ()
  ;; setup lsp fine tune
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-completion-provider :capf)
  (setq lsp-idle-delay 0.500)
  ;;iedit bug
  ;;need to wait for https://github.com/syl20bnr/evil-iedit-state/issues/27 releases
  (defalias 'iedit-cleanup 'iedit-lib-cleanup)
  ;;display guide line
  (setq-default
   ;; indent guide mode
   indent-guide-global-mode nil
   display-line-numbers-width 5
   display-line-numbers-width-start 5
   ;; use smartparens strict mode
   ;; dotspacemacs-smartparens-strict-mode t
   )
  ;; change line number format
  ;; (setq linum-format "%5d")
  ;; config evil-smartparens package
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
  (nyan-mode)
  (setq nyan-animate-nyancat t)
  (helm-icons-enable)
  (treemacs-resize-icons 16)
  (global-flycheck-mode)
  ;;my key binding
  (setq-default evil-escape-key-sequence "jj")
  (evil-define-key 'visual evil-surround-mode-map "s" 'evil-substitute)
  (evil-define-key 'visual evil-surround-mode-map "S" 'evil-surround-region)
  (global-set-key (kbd "C-S-k") 'drag-stuff-up)
  (global-set-key (kbd "C-S-j") 'drag-stuff-down)
  (global-set-key (kbd "C-,") 'helm-projectile-switch-to-buffer)
  (evil-global-set-key 'normal "H" 'evil-first-non-blank)
  (evil-global-set-key 'visual "H" 'evil-first-non-blank)
  (evil-global-set-key 'motion "H" 'evil-first-non-blank)
  (evil-global-set-key 'normal "L" (lambda () (interactive) (evil-end-of-line)))
  (evil-global-set-key 'visual "L" (lambda () (interactive) (evil-end-of-line)))
  (evil-global-set-key 'motion "L" (lambda () (interactive) (evil-end-of-line)))
  (define-key evil-motion-state-map "gl" 'evil-avy-goto-line)
  (define-key evil-normal-state-map "gl" 'evil-avy-goto-line)
  (define-key evil-motion-state-map "gw" 'evil-avy-goto-char-2)
  (define-key evil-normal-state-map "gw" 'evil-avy-goto-char-2)
  ;;Keep files in sync
  (global-auto-revert-mode 1)
  (setq global-auto-revert-non-file-buffers t)
  (setq auto-revert-verbose nil)
  (setq revert-without-query '(".*"))
  (setq tab-always-indent t)
  (setq auth-sources '("~/.config/authrc"))
  (with-eval-after-load 'spaceline-segments
    (spaceline-toggle-minor-modes-off)
    (spaceline-toggle-buffer-size-off))
  (with-eval-after-load 'dired
    (evil-define-key 'normal dired-mode-map
      "h" 'dired-up-directory
      "l" 'dired-find-file))
  ;; let diff to delta mode
  (magit-delta-mode)
  ;; powerline seperator
  (setq dotspacemacs-mode-line-theme '(all-the-icons :separator wave))
  ;; activate beacon
  (beacon-mode 1)
  ;; setup korean
  (set-language-environment "Korean")
  (prefer-coding-system 'utf-8)
  ;; setup rg modes
  (spacemacs/set-leader-keys "rg" 'rg-project)
)

(defun dotspacemacs/emacs-custom-settings ()
   (custom-set-variables
      '(blink-cursor-mode nil)
      '(column-number-mode t)
      '(custom-safe-themes
        '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "d74c5485d42ca4b7f3092e50db687600d0e16006d8fa335c69cf4f379dbd0eee" default))
      '(display-line-numbers-type 'relative)
      '(evil-want-Y-yank-to-eol nil)
      '(global-display-line-numbers-mode t)
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
      '(tool-bar-mode nil)
  )
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(helm-selection ((t (:extend t :background "VioletRed4" :foreground "gray100" :inverse-video nil)))))
)
