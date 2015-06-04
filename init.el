;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hacks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.live-packs/gnus-pack/lib/vendor/gnus/lisp/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Directories
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq my-base-dir "~/.emacs.d")
(setq my-tmp-dir (concat my-base-dir "/tmp"))
(setq my-private-dir (concat my-base-dir "/private"))

(add-to-list 'load-path my-base-dir)

(setq user-emacs-directory my-base-dir)
(setq custom-file (concat my-base-dir "/custom.el"))
(load custom-file 'noerror)

(add-to-list 'load-path (concat my-base-dir "/el-get"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; el-get
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path (concat my-base-dir "/el-get-user/recipes"))
(add-to-list 'el-get-recipe-path (concat my-base-dir "/el-get-git/recipes"))

(load-file (concat my-base-dir "/user.el"))

(el-get 'sync my-packages)

(load "server")
(unless (server-running-p) (server-start))
