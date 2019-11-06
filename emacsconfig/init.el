(global-linum-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#c5c8c6"))
 '(beacon-color "#cc6666")
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("35b0b0e531731e270708ddb342dc2e576a31fb298dcbc56a206596a43afac54f" "274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(fci-rule-color "#373b41")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (flycheck-tip flycheck-rebar3 edts use-package-hydra psc-ide neotree hindent exec-path-from-shell dracula-theme dante color-theme-sanityinc-tomorrow attrap advice-patch)))
 '(psc-ide-rebuild-on-save t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))
(tool-bar-mode -1)

;;---------------------------------------------------------------------------

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(exec-path-from-shell-initialize)


(add-to-list 'load-path "/Users/aaa/lib/emacs/purescript-mode/purescript-mode")
(require 'purescript-mode-autoloads)
(add-to-list 'Info-default-directory-list "/Users/aaa/lib/emacs/purescript-mode/purescript-mode")

;;---------------------------------------------------------------------------

;; purescript mode
(require 'psc-ide)
(add-hook 'purescript-mode-hook
  (lambda ()
    (psc-ide-mode)
    (company-mode)
    (flycheck-mode)
    (turn-on-purescript-indentation)))
(global-set-key (kbd "M-SPC") 'company-complete)
(customize-set-variable 'psc-ide-rebuild-on-save t)

(eval-after-load 'haskell-mode
          '(define-key haskell-mode-map [f7] 'haskell-navigate-imports))


;;---------------------------------------------------------------------------
;; haskell mode
(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'company-mode)
  (add-hook 'dante-mode-hook
   '(lambda () (flycheck-add-next-checker 'haskell-dante
                '(warning . haskell-hlint))))
  (add-hook 'haskell-mode-hook #'hindent-mode)
  (add-hook 'haskell-mode-hook 'dante-mode)
  )

;;---------------------------------------------------------------------------
;; erlang mode
(add-to-list 'load-path (car (file-expand-wildcards "/usr/local/opt/erlang/lib/erlang/lib/tools-*/emacs")))
(require 'erlang-start)
(setq erlang-root-dir "/usr/local/opt/erlang/")
(setq exec-path (cons "/usr/local/opt/erlang/bin" exec-path))
(setq erlang-man-root-dir "/usr/local/opt/erlang/lib/erlang/man")

(use-package flycheck
  :diminish flycheck-mode
  :after 'erlang-mode-hook
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (setq flycheck-display-errors-function nil
        flycheck-erlang-include-path '("../include")
        flycheck-erlang-library-path '()
        flycheck-check-syntax-automatically '(save)))

(push "~/.emacs.d/distel/elisp/" load-path)
(require 'distel)
(distel-setup)

;; prevent annoying hang-on-compile
(defvar inferior-erlang-prompt-timeout t)
;; default node name to emacs@localhost
(setq inferior-erlang-machine-options '("-sname" "emacs"))
;; tell distel to default to that node
(setq erl-nodename-cache
      (make-symbol
       (concat
        "emacs@"
        ;; Mac OS X uses "name.local" instead of "name", this should work
        ;; pretty much anywhere without having to muck with NetInfo
        ;; ... but I only tested it on Mac OS X.
                (car (split-string (shell-command-to-string "hostname"))))))

;;autocomplete
(add-hook 'after-init-hook 'global-company-mode)

(push "~/.emacs.d/distel-completion/" load-path)
(require 'company-distel)
(add-hook 'erlang-mode-hook
          (lambda ()
            (setq company-backends '(company-distel))))


;;---------------------------------------------------------------------------

;; tree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)



;;---------------------------------------------------------------------------

(load-theme 'dracula)

;;---------------------------------------------------------------------------


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
