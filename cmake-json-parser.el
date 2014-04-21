(require 'json)
(require 'flymake)

(defun cmake-compile-commands-file-name (build-directory)
  (expand-file-name "compile_commands.json" build-directory))

(defun cmake-load-compile-commands (filename)
  "Load a compile_commands.json file and index it by file."
  (let* ((json-object-type 'hash-table)
         (commands (make-hash-table :test 'equal))
         (json (json-read-file filename)))
    (progn
      (mapcar (lambda (x)
                (let ((file (gethash "file" x)))
                  (puthash file x commands)))
              json)
      commands)))

(defvar cmake-compile-commands-cache (make-hash-table) "A cache of all the parsed compile_commands.json files.")

(defun cmake-clear-compile-commands-cache ()
  (clrhash cmake-compile-commands-cache))


(defun cmake-clear-cache ()
  (interactive)
  (progn (cmake-clear-compile-commands-cache)))

(defun cmake-get-compile-commands (build-directory)
  (let ((filename (cmake-compile-commands-file-name build-directory)))
    (or (gethash filename cmake-compile-commands-cache)
        (puthash filename (cmake-load-compile-commands filename) cmake-compile-commands-cache))))

(defun cmake-get-compile-commands-for-current-file ()
  (interactive)
  (if cmake-build-directory ;; TODO this check does not work!
      (let ((compile-commands (cmake-get-compile-commands (car cmake-build-directory))))
        (if compile-commands
            (gethash (buffer-file-name) compile-commands)
          (error "No compile commands for current file! You should run cmake with -DCMAKE_EXPORT_COMPILE_COMMANDS=ON to generate json file: '%s'"
                 (cmake-compile-commands-file-name (car cmake-build-directory)))))
    (error "No cmake project recognized!")))
