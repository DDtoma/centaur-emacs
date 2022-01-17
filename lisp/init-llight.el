;; 个人临时配置
(use-package rime
  :defer nil
  ;; emacs-rime configration https://github.com/DogLooksGood/emacs-rime
  :ensure t
  :custom (default-input-method "rime")
  :config
  (defun +rime-predicate-org-syntax-punc-p ()
    (when (eq major-mode 'org-mode)
      (member rime--current-input-key '(91 93 42 126))))
  ;; 配置rime https://manateelazycat.github.io/emacs/2020/03/22/emacs-rime.html
  (setq rime-show-candidate 'posframe
        rime-user-data-dir "~/.emacs.d/rime"
        ;; 零时英文模式断言
        rime-disable-predicates '(
                                  meow-normal-mode-p
                                  meow-motion-mode-p
                                  meow-keypad-mode-p
                                  rime-predicate-ace-window-p  ;; 激活 ace-window-mode
                                  rime-predicate-hydra-p ;; 如果激活了一个 hydra keymap
                                  rime-predicate-after-alphabet-char-p ;; 在英文字符串之后（必须为以字母开头的英文字符串）
                                  rime-predicate-in-code-string-p ;; 在代码的字符串中，不含注释的字符串。
                                  +rime-predicate-org-syntax-punc-p
                                  )
        rime-inline-predicates '(
                                 rime-predicate-space-after-cc-p
                                 rime-predicate-current-uppercase-letter-p
                                 )
        ;; 显示零时英文状态，图标不高亮
        mode-line-mule-info '((:eval (rime-lighter)))
        )
  (with-eval-after-load "rime"
    (define-key rime-active-mode-map [tab] 'rime-inline-ascii)
    ;; 使用rime本身的快捷键
    (define-key rime-mode-map (kbd "C-`") 'rime-send-keybinding)
    ;; 断言成功后强制中文模式
    (define-key rime-mode-map (kbd "M-j") 'rime-force-enable))
  ;; 光标字符
  (setq rime-cursor "|")
  ;; (global-set-key (kbd "C-SPC") 'toggle-input-method)
  )

(use-package yaml-mode
  :ensure t)

(use-package meow
  :ensure t
  :custom
  (meow-global-mode 1)
  :defer nil
  :config
  (require 'meow)
  (defun meow-setup ()
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
    (meow-motion-overwrite-define-key
     '("j" . meow-next)
     '("k" . meow-prev)
     '("<escape>" . ignore))
    (meow-leader-define-key
     ;; SPC j/k will run the original command in MOTION state.
     '("j" . "H-j")
     '("k" . "H-k")
     ;; SPC + 单键绑定部分常用的功能
     '("s" . swiper)
     '("f" . counsel-find-file)
     '("r" . counsel-recentf)
     '("t" . youdao-dictionary-search-at-point+)
     '("b" . ivy-switch-buffer)
     '("p" . project-find-file)
     '("v" . magit-status)
     '("k" . all-the-icons-ivy-rich-kill-buffer)
     '("a" . counsel-rg)
     ;; Use SPC (0-9) for digit arguments.
     '("1" . meow-digit-argument)
     '("2" . meow-digit-argument)
     '("3" . meow-digit-argument)
     '("4" . meow-digit-argument)
     '("5" . meow-digit-argument)
     '("6" . meow-digit-argument)
     '("7" . meow-digit-argument)
     '("8" . meow-digit-argument)
     '("9" . meow-digit-argument)
     '("0" . meow-digit-argument)
     '("/" . meow-keypad-describe-key)
     '("?" . meow-cheatsheet))
    (meow-normal-define-key
     '("0" . meow-expand-0)
     '("9" . meow-expand-9)
     '("8" . meow-expand-8)
     '("7" . meow-expand-7)
     '("6" . meow-expand-6)
     '("5" . meow-expand-5)
     '("4" . meow-expand-4)
     '("3" . meow-expand-3)
     '("2" . meow-expand-2)
     '("1" . meow-expand-1)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("a" . meow-append)
     '("A" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("d" . meow-delete)
     '("D" . meow-backward-delete)
     '("e" . meow-next-word)
     '("E" . meow-next-symbol)
     '("f" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-insert)
     '("I" . meow-open-above)
     '("j" . meow-next)
     '("J" . meow-next-expand)
     '("k" . meow-prev)
     '("K" . meow-prev-expand)
     '("l" . meow-right)
     '("L" . meow-right-expand)
     '("m" . meow-join)
     '("n" . meow-search)
     '("o" . meow-block)
     '("O" . meow-to-block)
     '("p" . meow-yank)
     '("q" . meow-quit)
     '("Q" . meow-goto-line)
     '("r" . meow-replace)
     '("R" . meow-swap-grab)
     '("s" . meow-kill)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . meow-undo-in-selection)
     '("v" . meow-visit)
     '("w" . meow-mark-word)
     '("W" . meow-mark-symbol)
     '("x" . meow-line)
     '("X" . meow-goto-line)
     '("y" . meow-save)
     '("Y" . meow-sync-grab)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     '("<escape>" . ignore)))
  (meow-setup)
  ;; 设置状态栏上的显示内容
  (setq meow-keypad-describe-delay 1.0
        meow-replace-state-name-list '((normal . "N")
                                       (motion . "M")
                                       (keypad . "K")
                                       (insert . "I")
                                       (beacon . "B")))
  (meow-setup-line-number)
  (delete-selection-mode -1)
  )

(with-eval-after-load 'lsp-rust
  (require 'dap-gdb-lldb))

(provide 'init-llight)
