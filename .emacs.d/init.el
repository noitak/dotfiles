;; default directory
(cd "~/")

;; load path
(setq load-path
      (append
       (list (expand-file-name "~/.emacs.d/site-lisp")) load-path))

;; backup の保存先
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
        backup-directory-alist))

(setq auto-save-file-name-transforms
  `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; パッケージ情報の更新
(package-refresh-contents)

;; インストールするパッケージ
(defvar my/favorite-packages
  '(
    ;;;; for auto-complete
    auto-complete fuzzy popup pos-tip
    ;;;; buffer utils
    popwin elscreen yascroll buffer-move
    ;;;; flymake
    flycheck flymake-jslint
    ;;;; git
    magit git-gutter

    color-theme-modern
    ddskk
    graphql-mode
    dockerfile-mode
    docker-compose-mode
    typescript-mode
    clojure-mode
    web-mode
    ))

;; my/favorite-packagesからインストールしていないパッケージをインストール
(dolist (package my/favorite-packages)
  (unless (package-installed-p package)
    (package-install package)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 表示
;; Window size
(if (boundp 'window-system)
    (setq default-frame-alist
          (append (list
;                   '(foreground-color . "black")  ; 文字色
;                   '(background-color . "white")  ; 背景色
;                   '(border-color     . "white")  ; ボーダー色
;                   '(mouse-color      . "black")  ; マウスカーソルの色
;                   '(cursor-color     . "black")  ; カーソルの色
;                   '(cursor-type      . box)      ; カーソルの形状
                   '(top . 0) ; ウィンドウの表示位置（Y座標）
                   '(left . 0) ; ウィンドウの表示位置（X座標）
                   '(width . 80) ; ウィンドウの幅（文字数）
                   '(height . 48) ; ウィンドウの高さ（文字数）
                   )
                  default-frame-alist)))
(setq initial-frame-alist default-frame-alist )

;; Font set
;(create-fontset-from-ascii-font "Menlo-13:weight=normal:slant=normal" nil "menlokakugo")
;(set-fontset-font "fontset-menlokakugo"
;                  'unicode
;                  (font-spec :family "Hiragino Kaku Gothic ProN" :size 12)
;                  nil
;                  'append)
;(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))
(set-face-attribute 'default nil
                    :family "Ricty Diminished"
                    :height 120)
(setq-default line-spacing 0.2)

;;; color-theme-modern
; screen shots
; https://github.com/emacs-jp/replace-colorthemes/blob/master/screenshots.md
(load-theme 'misterioso t)
(enable-theme 'misterioso)


;; ツールバーを表示しない
;(tool-bar-mode 0)

;; タイトルバーにバッファ名を表示
(setq frame-title-format "%b")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key bind
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-cr" 'replace-string)
(global-set-key "\C-cR" 'replace-regexp)
(global-set-key "\C-cG" 'magit-status)

;; metaキーの変更
(setq mac-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; C-kで改行までカット
(setq kill-whole-line t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Color
;; リージョンに色を付ける
(setq transient-mark-mode t)

;; 対応する括弧をハイライト表示する
(show-paren-mode t)
(setq show-paren-style 'mixed)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 動作
;; 対応する括弧に%でジャンプする
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mode
; markdown
;(load "markdown-mode")

;(setq auto-mode-alist
;      (append '(("\\.md$" . markdown-mode)) auto-mode-alist)
;      )

; haskell-mode
; run % make EMACS=/Applications/Emacs.app/Contents/MacOS/EMACS
;(add-to-list 'load-path "~/.emacs.d/site-lisp/haskell-mode/")
;(require 'haskell-mode-autoloads)
;(add-to-list 'Info-default-directory-list "~/.emacs.d/site-lisp/haskell-mode/")
;(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

; migemo
;(require 'migemo)
;(setq migemo-command "cmigemo")
;(setq migemo-options '("-q" "--emacs"))
;; Set your installed path
;(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
;(setq migemo-user-dictionary nil)
;(setq migemo-regex-dictionary nil)
;(setq migemo-coding-system 'utf-8-unix)
;(migemo-init)

; golang
;(require 'go-mode-autoloads)
;(setq auto-mode-alist
;      (append '(("\\.go$" . go-mode)) auto-mode-alist)
;      )

; Dart
;(require 'dart-mode)
;(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))

; web-mode
;(require 'web-mode)
;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
;(defun my-web-mode-hook ()
;  "Hooks for Web mode."
;  (setq web-mode-attr-indent-offset nil)
;  (setq web-mode-markup-indent-offset 2)
;  (setq web-mode-css-indent-offset 2)
;  (setq web-mode-code-indent-offset 2)
;  (setq web-mode-sql-indent-offset 2)
;  (setq indent-tabs-mode nil)
;  (setq tab-width 2))
;(add-hook 'web-mode-hook 'my-web-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; for Mac OS Notification Center
(when (equal system-type 'darwin)
  (defvar notification-center-title "Emacs")

  (defun notification-center (msg)
    (let ((tmpfile (make-temp-file "notification-center")))
      (with-temp-file tmpfile
	(insert
	 (format "display notification \"%s\" with title \"%s\""
		 msg notification-center-title)))
      (unless (zerop (call-process "osascript" tmpfile))
	(message "Failed: Call AppleScript"))
      (delete-file tmpfile)))

  ;; ファイル名を開いたときにそれを通知する
  (defun my/find-file-hook ()
    (notification-center (format "Open '%s'" (buffer-name))))
  (add-hook 'find-file-hook 'my/find-file-hook)
  )


;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
; '(package-selected-packages
;   (quote
;    (ddskk ripgrep graphql-mode yaml-mode rust-mode plantuml-mode magit color-theme-modern anything))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-comment-face ((t (:foreground "#587F35"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#DFCF44"))))
 '(web-mode-css-property-name-face ((t (:foreground "#87CEEB"))))
 '(web-mode-css-pseudo-class ((t (:foreground "#DFCF44"))))
 '(web-mode-css-selector-face ((t (:foreground "#DFCF44"))))
 '(web-mode-css-string-face ((t (:foreground "#D78181"))))
 '(web-mode-doctype-face ((t (:foreground "#4A8ACA"))))
 '(web-mode-html-attr-equal-face ((t (:foreground "#FFFFFF"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#87CEEB"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#D78181"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "#4A8ACA"))))
 '(web-mode-html-tag-face ((t (:foreground "#4A8ACA"))))
 '(web-mode-server-comment-face ((t (:foreground "#587F35")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; plantuml
;; .pu拡張子のファイルをplantuml-modeで開く
;(add-to-list ‘auto-mode-alist ‘("\.pu$" . plantuml-mode))
(setq auto-mode-alist
      (append '(("\\.pu$" . plantuml-mode)) auto-mode-alist))


;; あなたのplantuml.jarファイルの絶対パスをかく
(setq plantuml-jar-path "/usr/local/Cellar/plantuml/1.2019.13/libexec/plantuml.jar")
;; javaにオプションを渡したい場合はここにかく
(setq plantuml-java-options "")
;; plantumlのプレビューをsvg, pngにしたい場合はここをコメントイン
;; デフォルトでアスキーアート
;;(setq plantuml-output-type "svg")
;; 日本語を含むUMLを書く場合はUTF-8を指定
(setq plantuml-options "-charset UTF-8")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; .js, .jsx を web-mode で開く
(add-to-list 'auto-mode-alist '("\\.js[x]?$" . web-mode))

;; 拡張子 .js でもJSX編集モードに
(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))

;; インデント
(add-hook 'web-mode-hook
          '(lambda ()
             (setq web-mode-attr-indent-offset nil)
             (setq web-mode-markup-indent-offset 2)
             (setq web-mode-css-indent-offset 2)
             (setq web-mode-code-indent-offset 2)
             (setq web-mode-sql-indent-offset 2)
             (setq indent-tabs-mode nil)
             (setq tab-width 2)
          ))

;; 色
(put 'upcase-region 'disabled nil)

(add-to-list 'auto-mode-alist '("\\.vue$" . web-mode))

;; SKK
(when (require 'skk nil t)
;  (global-set-key (kbd "C-x C-j") 'skk-auto-fill-mode)
  (global-set-key (kbd "C-x C-j") 'skk-mode)
  (setq default-input-method "japanese-skk")
  (require 'skk-study))
(setq skk-large-jisyo "~/.emacs.d/SKK-JISYO.L")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (web-mode clojure-mode dockerfile-mode typescript-mode docker-compose-mode ddskk color-theme-modern git-gutter magit flymake-jslint flycheck buffer-move yascroll elscreen popwin pos-tip fuzzy auto-complete))))
