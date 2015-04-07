;;; projectile-ember.el --- Minor mode for Ember projects based on projectile-mode

;; Copyright (C) 2015 Tom Ridge

;; Author:            Tom Ridge <tomridge2@gmail.com>
;; URL:               https://github.com/ridget/projectile-ember
;; Version:           0.0.1
;; Keywords:          ember, projectile
;; Package-Requires:  ((projectile "1.0.0-cvs") (inflections "1.1")) 

;; This file is NOT part of GNU Emacs.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; To make it start alongside projectile-mode:
;;
;;    (add-hook 'projectile-mode-hook 'projectile-ember-on)
;;
;;; Code:

(require 'projectile)
(require 'inflections)
(require 'f)

(defgroup projectile-ember nil
  "Ember mode based on projectile"
  :prefix "projectile-ember-"
  :group 'projectile)

;;(defcustom projectile-ember-controller-keywords
;;  '("logger" "polymorphic_path" "polymorphic_url" "mail" "render" "attachments"
    ;;"default" "helper" "helper_attr" "helper_method" "layout" "url_for"
    ;;"serialize" "exempt_from_layout" "filter_parameter_logging" "hide_action"
    ;;"cache_sweeper" "protect_from_forgery" "caches_page" "cache_page"
    ;;"caches_action" "expire_page" "expire_action" "rescue_from" "params"
    ;;"request" "response" "session" "flash" "head" "redirect_to"
    ;;"render_to_string" "respond_with" "before_filter" "append_before_filter"
    ;;"before_action" "append_before_action"
    ;;"prepend_before_filter" "after_filter" "append_after_filter"
    ;;"prepend_after_filter" "around_filter" "append_around_filter"
    ;;"prepend_around_filter" "skip_before_filter" "skip_after_filter" "skip_filter"
    ;;"prepend_before_action" "after_action" "append_after_action"
    ;;"prepend_after_action" "around_action" "append_around_action"
    ;;"prepend_around_action" "skip_before_action" "skip_after_action" "skip_action")
  ;;"List of keywords to highlight for controllers"
  ;;:group 'projectile-ember
  ;;:type '(repeat string))

;; (defcustom projectile-ember-migration-keywords
;;   '("create_table" "change_table" "drop_table" "rename_table" "add_column"
;;     "rename_column" "change_column" "change_column_default" "remove_column"
;;     "add_index" "remove_index" "rename_index" "execute")
;;   "List of keywords to highlight for migrations"
;;   :group 'projectile-ember
;;   :type '(repeat string))

;; (defcustom projectile-ember-model-keywords
;;   '("default_scope" "named_scope" "scope" "serialize" "belongs_to" "has_one"
;;     "has_many" "has_and_belongs_to_many" "composed_of" "accepts_nested_attributes_for"
;;     "before_create" "before_destroy" "before_save" "before_update" "before_validation"
;;     "before_validation_on_create" "before_validation_on_update" "after_create"
;;     "after_destroy" "after_save" "after_update" "after_validation"
;;     "after_validation_on_create" "after_validation_on_update" "around_create"
;;     "around_destroy" "around_save" "around_update" "after_commit" "after_find"
;;     "after_initialize" "after_rollback" "after_touch" "attr_accessible"
;;     "attr_protected" "attr_readonly" "validates" "validate" "validate_on_create"
;;     "validate_on_update" "validates_acceptance_of" "validates_associated"
;;     "validates_confirmation_of" "validates_each" "validates_exclusion_of"
;;     "validates_format_of" "validates_inclusion_of" "validates_length_of"
;;     "validates_numericality_of" "validates_presence_of" "validates_size_of"
;;     "validates_existence_of" "validates_uniqueness_of" "validates_with")
;;   "List of keywords to highlight for models"
;;   :group 'projectile-ember
;;   :type '(repeat string))

;; (defcustom projectile-ember-view-keywords
;;   '("action_name" "atom_feed" "audio_path" "audio_tag" "auto_discovery_link_tag"
;;     "button_tag" "button_to" "button_to_function" "cache" "capture" "cdata_section"
;;     "check_box" "check_box_tag" "collection_select" "concat" "content_for"
;;     "content_tag" "content_tag_for" "controller" "controller_name"
;;     "controller_path" "convert_to_model" "cookies" "csrf_meta_tag" "csrf_meta_tags"
;;     "current_cycle" "cycle" "date_select" "datetime_select" "debug"
;;     "distance_of_time_in_words" "distance_of_time_in_words_to_now" "div_for"
;;     "dom_class" "dom_id" "email_field" "email_field_tag" "escape_javascript"
;;     "escape_once" "excerpt" "favicon_link_tag" "field_set_tag" "fields_for"
;;     "file_field" "file_field_tag" "flash" "form_for" "form_tag"
;;     "grouped_collection_select" "grouped_options_for_select" "headers"
;;     "hidden_field" "hidden_field_tag" "highlight" "image_alt" "image_path"
;;     "image_submit_tag" "image_tag" "j" "javascript_cdata_section"
;;     "javascript_include_tag" "javascript_path" "javascript_tag" "l" "label"
;;     "label_tag" "link_to" "link_to_function" "link_to_if" "link_to_unless"
;;     "link_to_unless_current" "localize" "logger" "mail_to" "number_field"
;;     "number_field_tag" "number_to_currency" "number_to_human" "number_to_human_size"
;;     "number_to_percentage" "number_to_phone" "number_with_delimiter"
;;     "number_with_precision" "option_groups_from_collection_for_select"
;;     "options_for_select" "options_from_collection_for_select" "params"
;;     "password_field" "password_field_tag" "path_to_audio" "path_to_image"
;;     "path_to_javascript" "path_to_stylesheet" "path_to_video" "phone_field"
;;     "phone_field_tag" "pluralize" "provide" "radio_button" "radio_button_tag"
;;     "range_field" "range_field_tag" "raw" "render" "request"
;;     "request_forgery_protection_token" "reset_cycle" "response" "safe_concat"
;;     "safe_join" "sanitize" "sanitize_css" "search_field" "search_field_tag"
;;     "select" "select_date" "select_datetime" "select_day" "select_hour"
;;     "select_minute" "select_month" "select_second" "select_tag" "select_time"
;;     "select_year" "session" "simple_format" "strip_links" "strip_tags"
;;     "stylesheet_link_tag" "stylesheet_path" "submit_tag" "t" "tag" "telephone_field"
;;     "telephone_field_tag" "text_area" "text_area_tag" "text_field" "text_field_tag"
;;     "time_ago_in_words" "time_select" "time_tag" "time_zone_options_for_select"
;;     "time_zone_select" "translate" "truncate" "url_field" "url_field_tag"
;;     "url_for" "url_options" "video_path" "video_tag" "word_wrap")
;;   "List of keywords to highlight for views"
;;   :group 'projectile-ember
;;   :type '(repeat string))

;; (defcustom projectile-ember-active-support-keywords
;;   '("alias_attribute" "with_options" "delegate")
;;   "List of keywords to highlight for all `projectile-ember-mode' buffers"
;;   :group 'projectile-ember
;;   :type '(repeat string))

(defcustom projectile-ember-font-lock-face-name 'font-lock-keyword-face
  "Face to be used for higlighting the ember keywords")

(defcustom projectile-ember-views-re
  "\\.\\(?:js\\)$"
  "Regexp for filtering for view files"
  :group 'projectile-ember
  :type 'string)

(defcustom projectile-ember-templates-re
  "\\.\\(?:hbs\\|handlebars\\|emblem\\)$"
  "Regexp for filtering for template files"
  :group 'projectile-ember
  :type 'string)

(defcustom projectile-ember-errors-re
  "\\([0-9A-Za-z@_./\:-]+\\.js\\):?\\([0-9]+\\)?"
  "The regex used to find errors with file paths."
  :group 'projectile-ember
  :type 'string)

(defcustom projectile-ember-generate-filepath-re
  "^\\s-+\\(?:create\\|exists\\|conflict\\|skip\\)\\s-+\\(.+\\)$"
  "The regex used to find file paths in `projectile-ember-generate-mode'."
  :group 'projectile-ember
  :type 'string)

(defcustom projectile-ember-stylesheet-dirs
  '("app/styles/")
  "The list of directories to look for the stylesheet files in."
  :group 'projectile-ember
  :type '(repeat string))

(defcustom projectile-ember-expand-snippet t
  "If not nil newly created buffers will be pre-filled with class skeleton.")

(defcustom projectile-ember-add-keywords t
  "If not nil the ember keywords will be font locked in the mode's bufffers.")

(defcustom projectile-ember-keymap-prefix (kbd "C-c r")
  "`projectile-ember-mode' keymap prefix."
  :group 'projectile-ember
  :type 'string)

(defcustom projectile-ember-server-mode-ansi-colors t
  "If not nil `projectile-ember-server-mode' will apply the ansi colors in its buffer."
  :group 'projectile-ember
  :type 'boolean)

(defcustom projectile-ember-discover-bind "s-r"
  "The :bind option that will be passed `discover-add-context-menu' if available")

(defvar projectile-ember-server-buffer-name "*projectile-ember-server*")

(defvar projectile-ember-generators
  '(("assets" (("app/styles/"
                "app//\\(?:styles\\)/\\(.+?\\)\\..+$")))
    ("controller" (("app/controllers/" "app/controllers/\\(.+\\)\\.js$")))
    ("route" (("app/routes/" "app/routes/\\(.+\\)\\.js$")))
    ("helper" (("app/helpers/" "app/helpers/\\(.+\\).js$")))
    ("test" (("tests/" "tests/\\(.+\\)_test\\.js$")))
    ("model" (("app/models/" "app/models/\\(.+\\)\\.js$")))
    ("resource" (("app/models/" "app/models/\\(.+\\)\\.js$")))
    ("scaffold" (("app/models/" "app/models/\\(.+\\)\\.js$")))


(defmacro projectile-ember-with-root (body-form)
  `(let ((default-directory (projectile-ember-root)))
     ,body-form))

(defmacro projectile-ember-find-current-resource (dir re fallback)
  "RE will be the argument to `s-lex-format'.

The bound variables are \"singular\" and \"plural\"."
  `(let* ((singular (projectile-ember-current-resource-name))
          (plural (pluralize-string singular))
          (abs-current-file (buffer-file-name (current-buffer)))
          (current-file (if abs-current-file
                            (file-relative-name abs-current-file
                                                (projectile-project-root))))
          (choices (projectile-ember-choices
                    (list (list ,dir (s-lex-format ,re)))))
          (files (projectile-ember-hash-keys choices)))
     (if (eq files ())
         (funcall ,fallback)
       (projectile-ember-goto-file
        (if (= (length files) 1)
            (gethash (-first-item files) choices)
          (gethash (projectile-completing-read "Which exactly: " files)
                   choices))))))


(defun projectile-ember-highlight-keywords (keywords)
  "Highlight the passed KEYWORDS in current buffer."
  (font-lock-add-keywords
   nil
   (list (list
          (concat "\\(^\\|[^_:.@$]\\|\\.\\.\\)\\b"
                  (regexp-opt keywords t)
                  "\\_>")
          (list 2 projectile-ember-font-lock-face-name)))))

(defun projectile-ember-add-keywords-for-file-type ()
  "Apply extra font lock keywords specific to models, routes etc."
  (loop for (re keywords) in `(("app/controllers/.+\\.js$"   ,projectile-ember-controller-keywords)
                               ("app/models/.+\\.js$" ,projectile-ember-model-keywords)
                               ("app/routes/.+\\.js$" ,projectile-ember-route-keywords)
        do (when (and (buffer-file-name) (string-match-p re (buffer-file-name)))
             (projectile-ember-highlight-keywords
              (append keywords projectile-ember-active-support-keywords)))))

(defun projectile-ember-choices (dirs)
  "Uses `projectile-dir-files' function to find files in directories.

The DIRS is list of lists consisting of a directory path and regexp to filter files from that directory.
Returns a hash table with keys being short names and values being relative paths to the files."
  (let ((hash (make-hash-table :test 'equal)))
    (loop for (dir re) in dirs do
          (loop for file in (projectile-dir-files (projectile-expand-root dir)) do
                (when (string-match re file)
                  (puthash (match-string 1 file) file hash))))
    hash))

(defun projectile-ember-hash-keys (hash)
  (if (boundp 'hash-table-keys)
      (hash-table-keys hash)
    (let (keys)
      (maphash (lambda (key value) (setq keys (cons key keys))) hash)
      keys)))

(defmacro projectile-ember-find-resource (prompt dirs &optional newfile-template)
  "Presents files from DIRS to the user using `projectile-completing-read'.

If users chooses a non existant file and NEWFILE-TEMPLATE is not nil
it will use that variable to interpolate the name for the new file.
NEWFILE-TEMPLATE will be the argument for `s-lex-format'.
The bound variable is \"filename\"."
  `(let* ((choices (projectile-ember-choices ,dirs))
          (filename (or
                     (projectile-completing-read ,prompt (projectile-ember-hash-keys choices))
                     (user-error "The completion system you're using does not allow inputting arbitrary value.")))
          (filepath (gethash filename choices)))
     (if filepath
         (projectile-ember-goto-file filepath)
       (when ,newfile-template
         (projectile-ember-goto-file (s-lex-format ,newfile-template) t)))))

(defun projectile-ember-find-model ()
  (interactive)
  (projectile-ember-find-resource
   "model: "
   '(("app/models/" "/models/\\(.+\\)\\.js$"))
   "app/models/${filename}.js"))

(defun projectile-ember-find-controller ()
  (interactive)
  (projectile-ember-find-resource
   "controller: "
   '(("app/controllers/" "/controllers/\\(.+\\)\\.js$"))
   "app/controllers/${filename}.js"))

(defun projectile-ember-find-component ()
  (interactive)
  (projectile-ember-find-resource
   "component: "
   `(("app/components/" ,(concat "app/components/\\(.+\\)" projectile-ember-components-re)))
   "app/components/${filename}"))

(defun projectile-ember-find-view ()
  (interactive)
  (projectile-ember-find-resource
   "view: "
   `(("app/views/" ,(concat "app/views/\\(.+\\)" projectile-ember-views-re)))
   "app/views/${filename}"))

(defun projectile-ember-find-template ()
  (interactive)
  (projectile-ember-find-resource
   "template: "
   `(("app/templates/" ,(concat "app/templates/\\(.+\\)" projectile-ember-templates-re)))
   "app/templates/${filename}"))

(defun projectile-ember-find-helper ()
  (interactive)
  (projectile-ember-find-resource
   "helper: "
   '(("app/helpers/" "/helpers/\\(.+\\).js$"))
   "app/helpers/${filename}.js"))

(defun projectile-ember-find-test ()
  (interactive)
  (projectile-ember-find-resource
   "test: "
   '(("test/" "test/\\(.+\\)-test\\.js$"))
   "spec/${filename}-test.js"))

(defun projectile-ember-find-stylesheet ()
  (interactive)
  (projectile-ember-find-resource
   "stylesheet: "
   (--map (list it "/\\(.+\\)\\.[^.]+$") projectile-ember-stylesheet-dirs)))

(defun projectile-ember-find-current-model ()
  (interactive)
  (projectile-ember-find-current-resource "app/models/"
                                          "/${singular}\\.js$"
                                          'projectile-ember-find-model))

(defun projectile-ember-find-current-controller ()
  (interactive)
  (projectile-ember-find-current-resource "app/controllers/"
                                          "app/controllers/\\(.*${plural}\\)_controller\\.js$"
                                          'projectile-ember-find-controller))

(defun projectile-ember-find-current-template ()
  (interactive)
  (projectile-ember-find-current-resource "app/templates/"
                                          "/${plural}/\\(.+\\)$"
                                          'projectile-ember-find-template))

(defun projectile-ember-find-current-test ()
  (interactive)
  (projectile-toggle-between-implementation-and-test))



(defun projectile-ember-current-resource-name ()
  "Returns a resource name extracted from the name of the currently visiting file"
  (let ((file-name (buffer-file-name)))
    (if file-name
        (singularize-string
         (loop for re in '("app/models/\\(?:.+/\\)*\\(.+\\)\\.js"
                           "app/controllers/\\(?:.+/\\)*\\(.+\\)_controller\\.rb$"
                           "app/templates/\\(?:.+/\\)*\\(.+\\)/[^/]+$"
                           "app/styles/\\(?:.+/\\)*\\(.+\\)\\.css\\(?:\\.scss\\)$"
                           "\\(?:test\\)/\\(?:fixtures\\)/\\(.+?\\))?\\.\\(?:.js\\)$")
               until (string-match re file-name)
               finally return (match-string 1 file-name))))))

(defun projectile-ember-list-entries (fun dir)
  (--map
   (substring it (length (concat (projectile-ember-root) dir)))
   (funcall fun (projectile-expand-root dir))))

(defun projectile-ember-find-log ()
  (interactive)
  ;;logs tend to not be under scm so do not resort to projectile-dir-files
  (find-file (projectile-expand-root
              (concat
               "log/"
               (projectile-completing-read
                "log: "
                (projectile-ember-list-entries 'f-files "log/")))))
  (auto-revert-tail-mode +1)
  (setq-local auto-revert-verbose nil)
  (buffer-disable-undo)
  (projectile-ember-on))

(defun projectile-ember-rake (arg)
  (interactive "P")
  (rake arg 'projectile-ember-compilation-mode))

(defun projectile-ember-root ()
  "Returns ember root directory if this file is a part of a Ember application else nil"
  (ignore-errors
    (let ((root (projectile-project-root)))
      (when (file-exists-p (expand-file-name "config/environment.js" root))
        root))))

(defun projectile-ember-expand-snippet-maybe ()
  (when (and (fboundp 'yas-expand-snippet)
             (and (buffer-file-name) (not (file-exists-p (buffer-file-name))))
             (s-blank? (buffer-string))
             (projectile-ember-expand-corresponding-snippet))))

(defun projectile-ember--expand-snippet-for-module (last-part)
  (let ((parts (projectile-ember-classify (match-string 1 name))))
    (format
     (concat
      (s-join "" (--map (s-lex-format "module ${it}\n") (butlast parts)))
      last-part
      (s-join "" (make-list (1- (length parts)) "\nend")))
     (-last-item parts)))
  )

(defun projectile-ember-expand-corresponding-snippet ()
  (let ((name (buffer-file-name)))
    (yas-expand-snippet
     (cond ((string-match "app/[^/]+/concerns/\\(.+\\)\\.js$" name)
            (format
             "module %s\n  extend ActiveSupport::Concern\n$1\nend"
             (s-join "::" (projectile-ember-classify (match-string 1 name)))))
           ((string-match "app/controllers/\\(.+\\)\\.js$" name)
            (format
             "class %s < ${1:ApplicationController}\n$2\nend"
             (s-join "::" (projectile-ember-classify (match-string 1 name)))))
           ((string-match "spec/[^/]+/\\(.+\\)_spec\\.js$" name)
            (format
             "require \"spec_helper\"\n\ndescribe %s do\n$1\nend"
             (s-join "::" (projectile-ember-classify (match-string 1 name)))))
           ((string-match "app/models/\\(.+\\)\\.js$" name)
            (format
             "class %s < ${1:ActiveRecord::Base}\n$2\nend"
             (s-join "::" (projectile-ember-classify (match-string 1 name)))))
           ((string-match "lib/\\(.+\\)\\.js$" name)
            (projectile-ember--expand-snippet-for-module "${1:module} %s\n$2\nend"))
           ((string-match "app/\\(?:[^/]+\\)/\\(.+\\)\\.js$" name)
            (projectile-ember--expand-snippet-for-module "${1:class} %s\n$2\nend"))))))

(defun projectile-ember-classify (name)
  "Accepts a filepath, splits it by '/' character and classifieses each of the element"
  (--map (replace-regexp-in-string "_" "" (upcase-initials it)) (split-string name "/")))

(defun projectile-ember-declassify (name)
  "Converts passed string to a relative filepath."
  (let ((case-fold-search nil))
    (downcase
     (replace-regexp-in-string
      "::" "/"
      (replace-regexp-in-string
       " " "_"
       (replace-regexp-in-string
        "\\([a-z]\\)\\([A-Z]\\)" "\\1 \\2" name))))))

(defun projectile-ember-server ()
  "Runs ember server command"
  (interactive)
  (if (member projectile-ember-server-buffer-name (mapcar 'buffer-name (buffer-list)))
      (switch-to-buffer projectile-ember-server-buffer-name)
    (projectile-ember-with-root
     (compile (projectile-ember-with-preloader :spring "bundle exec spring ember server"
                                               :zeus "zeus server"
                                               :vanilla "bundle exec ember server")
              'projectile-ember-server-mode))))

(defun projectile-ember--completion-in-region ()
  (interactive)
  (let ((generators (--map (concat (car it) " ") projectile-ember-generators)))
    (when (<= (minibuffer-prompt-end) (point))
      (completion-in-region (minibuffer-prompt-end) (point-max)
                            generators))))

(defun projectile-ember--generate-with-completion (command)
  (let ((keymap (copy-keymap minibuffer-local-map)))
    (define-key keymap (kbd "<tab>") 'projectile-ember--completion-in-region)
    (concat command (read-from-minibuffer command nil keymap))))

(defun projectile-ember-generate ()
  "Runs ember generate command"
  (interactive)
  (projectile-ember-with-root
   (let ((command-prefix (projectile-ember-with-preloader
                          :spring "bundle exec spring ember generate "
                          :zeus "zeus generate "
                          :vanilla "bundle exec ember generate ")))
     (compile
      (projectile-ember--generate-with-completion command-prefix)
      'projectile-ember-generate-mode))))

(defun projectile-ember--destroy-read (command)
  (let ((keymap (copy-keymap minibuffer-local-map)))
    (define-key keymap (kbd "<tab>") 'exit-minibuffer)
    (read-from-minibuffer command nil keymap)))

(defun projectile-ember--destroy-with-completion (command)
  (let* ((user-input (projectile-ember--destroy-read command))
         (completion (try-completion user-input
                                     projectile-ember-generators))
         (dirs (cdr (-flatten-n 2 (--filter (string= completion (car it))
                                            projectile-ember-generators))))
         (prompt (concat command completion " ")))
    (if completion
        (concat prompt
                (projectile-completing-read
                 prompt
                 (projectile-ember-hash-keys (projectile-ember-choices dirs))))
      (concat command user-input))))

(defun projectile-ember-destroy ()
  "Runs ember destroy command."
  (interactive)
  (projectile-ember-with-root
   (let ((command-prefix (projectile-ember-with-preloader
                          :spring "bundle exec spring ember destroy "
                          :zeus "zeus destroy "
                          :vanilla "bundle exec ember destroy ")))
     (compile
      (projectile-ember--destroy-with-completion command-prefix)
      'projectile-ember-compilation-mode))))

(defun projectile-ember-sanitize-and-goto-file (dir name &optional ext)
  "Calls `projectile-ember-goto-file' with passed arguments sanitizing them before."
  (projectile-ember-goto-file
   (concat
    (projectile-ember-sanitize-dir-name dir) (projectile-ember-declassify name) ext)))

(defun projectile-ember-goto-file (filepath &optional ask)
  "Finds the FILEPATH after expanding root."
  (projectile-ember-ff (projectile-expand-root filepath) ask))

(defun projectile-ember-goto-gem (gem)
  "Uses `bundle-open' to open GEM. If the function is not defined notifies user."
  (if (not (fboundp 'bundle-open))
      (user-error "Please install bundler.el from https://github.com/tobiassvn/bundler.el")
    (message "Using bundle-open command to open the gem")
    (bundle-open (car (s-split "/" gem)))))

(defun projectile-ember-goto-asset-at-point (dirs)
  (let ((name
         (projectile-ember-sanitize-name (thing-at-point 'filename))))
    (projectile-ember-ff
     (loop for dir in dirs
           for re = (s-lex-format "${dir}${name}\\..+$")
           for files = (projectile-dir-files (projectile-expand-root dir))
           for file = (--first (string-match-p re it) files)
           until file
           finally return (and file (projectile-expand-root file))))))

(defun projectile-ember-goto-file-at-point ()
  "Tries to find file at point"
  (interactive)
  (let ((name (projectile-ember-name-at-point))
        (line (projectile-ember-current-line))
        (case-fold-search nil))
    (cond ((string-match-p "\\_<render\\_>" line)
           (projectile-ember-goto-template-at-point))

          ((string-match-p "^\\s-*//= require .+\\s-*$" line)
           (projectile-ember-goto-asset-at-point projectile-ember-javascript-dirs))

          ((string-match-p "^\\s-*\\#= require .+\\s-*$" line)
           (projectile-ember-goto-asset-at-point projectile-ember-javascript-dirs))

          ((string-match-p "\\_<javascript_include_tag\\_>" line)
           (projectile-ember-goto-asset-at-point projectile-ember-javascript-dirs))

          ((string-match-p "^\\s-*\\*= require .+\\s-*$" line)
           (projectile-ember-goto-asset-at-point projectile-ember-stylesheet-dirs))

          ((string-match-p "^\\s-*\\@import .+\\s-*$" line)
           (projectile-ember-goto-asset-at-point projectile-ember-stylesheet-dirs))

          ((string-match-p "\\_<stylesheet_link_tag\\_>" line)
           (projectile-ember-goto-asset-at-point projectile-ember-stylesheet-dirs))

          ((string-match-p "\\_<require_relative\\_>" line)
           (projectile-ember-ff (expand-file-name (concat (thing-at-point 'filename) ".js"))))

          ((string-match-p "\\_<require\\_>" line)
           (projectile-ember-goto-gem (thing-at-point 'filename)))

          ((string-match-p "\\_<gem\\_>" line)
           (projectile-ember-goto-gem (thing-at-point 'filename)))

          ((not (string-match-p "^[A-Z]" name))
           (projectile-ember-sanitize-and-goto-file "app/models/" (singularize-string name) ".js"))

          ((string-match-p "^[A-Z]" name)
           (loop for dir in (-concat
                             (--map
                              (concat "app/" it)
                              (projectile-ember-list-entries 'f-directories "app/"))
                             '("lib/"))
                 until (projectile-ember-sanitize-and-goto-file dir name ".js"))))))

(defun projectile-ember--view-p (path)
  (string-prefix-p "app/views/" (s-chop-prefix (projectile-ember-root) path)))

(defun projectile-ember--ignore-buffer-p ()
  "Returns t if `projectile-ember' should not be enabled for the current buffer"
  (string-match-p "\\*\\(Minibuf-[0-9]+\\|helm mini\\)\\*" (buffer-name)))

(defun projectile-ember-extract-region (partial-name)
  (interactive (list (file-truename (read-file-name "The name of the partial: " default-directory))))
  (let ((projectile-ember-expand-snippet nil)
        (snippet (cdr (assoc (f-ext partial-name) projectile-ember-extracted-region-snippet)))
        (path (replace-regexp-in-string "\/_" "/" (s-chop-prefix
                                                   (projectile-expand-root "app/views/")
                                                   (first (s-slice-at "\\." partial-name))))))
    (kill-region (region-beginning) (region-end))
    (deactivate-mark)
    (when (projectile-ember--view-p (buffer-file-name))
      (insert (format snippet path))
      (indent-according-to-mode)
      (when (not (looking-at-p "\n"))
        (insert "\n")))
    (find-file partial-name)
    (yank)
    (indent-region (point-min) (point-max))))

(defun projectile-ember-template-name (template)
  (-first-item (s-split "\\." (-last-item (s-split "/" template)))))

(defun projectile-ember-template-format (template)
  (let ((at-point-re "\\.\\([^.]+\\)\\.[^.]+$")
        (at-line-re "formats\\(?:'\"\\|:\\)?\\s-*\\(?:=>\\)?\\s-*\\[[:'\"]\\([a-zA-Z0-9]+\\)['\"]?\\]"))
    (cond ((string-match at-point-re template)
           (match-string 1 template))
          ((string-match at-line-re (projectile-ember-current-line))
           (match-string 1 (projectile-ember-current-line)))
          (t
           (when (string-match at-point-re (buffer-file-name))
             (match-string 1 (buffer-file-name)))))))

(defun projectile-ember-template-dir (template)
  (projectile-ember-sanitize-dir-name
   (cond ((string-match "\\(.+\\)/[^/]+$" template)
          (projectile-expand-root
           (concat "app/views/" (match-string 1 template))))
         ((string-match "app/controllers/\\(.+\\)_controller\\.js$" (buffer-file-name))
          (projectile-expand-root
           (concat "app/views/" (match-string 1 (buffer-file-name)))))
         (t
          default-directory))))

(defun projectile-ember--goto-template-at-point (dir name format)
  (loop for processor in '("erb" "haml" "slim")
        for template = (s-lex-format "${dir}${name}.${format}.${processor}")
        for partial = (s-lex-format "${dir}_${name}.${format}.${processor}")
        until (or
               (projectile-ember-ff template)
               (projectile-ember-ff partial))))

(defun projectile-ember-goto-template-at-point ()
  (interactive)
  (let* ((template (projectile-ember-filename-at-point))
         (dir (projectile-ember-template-dir template))
         (name (projectile-ember-template-name template))
         (format (projectile-ember-template-format template)))
    (if format
        (or (projectile-ember--goto-template-at-point dir name format)
            (projectile-ember--goto-template-at-point (projectile-expand-root "app/views/application/")
                                                      name
                                                      format))
      (message "Could not recognize the template's format")
      (dired dir))))

(defun projectile-ember-goto-gemfile ()
  (interactive)
  (projectile-ember-goto-file "Gemfile"))

(defun projectile-ember-goto-schema ()
  (interactive)
  (projectile-ember-goto-file "db/schema.js"))

(defun projectile-ember-goto-seeds ()
  (interactive)
  (projectile-ember-goto-file "db/seeds.js"))

(defun projectile-ember-goto-routes ()
  (interactive)
  (projectile-ember-goto-file "config/routes.js"))

(defun projectile-ember-goto-spec-helper ()
  (interactive)
  (projectile-ember-goto-file "spec/spec_helper.js"))

(defun projectile-ember-ff (path &optional ask)
  "Calls `find-file' function on PATH when it is not nil and the file exists.

If file does not exist and ASK in not nil it will ask user to proceed."
  (if (or (and path (file-exists-p path))
          (and ask (yes-or-no-p (s-lex-format "File does not exists. Create a new buffer ${path} ?"))))
      (find-file path)))

(defun projectile-ember-name-at-point ()
  (projectile-ember-sanitize-name (symbol-name (symbol-at-point))))

(defun projectile-ember-filename-at-point ()
  (projectile-ember-sanitize-name (thing-at-point 'filename)))

(defun projectile-ember-apply-ansi-color ()
  (read-only-mode)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (read-only-mode))

(defun projectile-ember--log-buffer-find-template (button)
  (projectile-ember-sanitize-and-goto-file "app/views/" (button-label button)))

(defun projectile-ember--log-buffer-find-controller (button)
  (projectile-ember-sanitize-and-goto-file "app/controllers/" (button-label button) ".js"))

(defun projectile-ember--generate-buffer-make-buttons (buffer exit-code)
  (with-current-buffer buffer
    (goto-char 0)
    (while (re-search-forward projectile-ember-generate-filepath-re (max-char) t)
      (make-button
       (match-beginning 1)
       (match-end 1)
       'action
       'projectile-ember-generate-ff
       'follow-link
       t))))

(defun projectile-ember-server-make-buttons ()
  (projectile-ember--log-buffer-make-buttons compilation-filter-start (point)))

(defun projectile-ember--log-buffer-make-buttons (start end)
  (save-excursion
    (goto-char start)
    (while (not (= (point) end))
      (cond ((re-search-forward "Rendered \\([^ ]+\\)" (line-end-position) t)
             (make-button (match-beginning 1) (match-end 1) 'action 'projectile-ember--log-buffer-find-template 'follow-link t))
            ((re-search-forward "Processing by \\(.+\\)#\\(?:[^ ]+\\)" (line-end-position) t)
             (make-button (match-beginning 1) (match-end 1) 'action 'projectile-ember--log-buffer-find-controller 'follow-link t)))
      (next-line))))

(defun projectile-ember-server-terminate ()
  (let ((process (get-buffer-process projectile-ember-server-buffer-name)))
    (when process (signal-process process 15))))

(defun projectile-ember-generate-ff (button)
  (find-file (projectile-expand-root (button-label button))))

(defun projectile-ember-sanitize-name (name)
  (when (or
         (and (s-starts-with? "'" name) (s-ends-with? "'" name))
         (and (s-starts-with? "\"" name) (s-ends-with? "\"" name)))
    (setq name (substring name 1 -1)))
  (when (s-starts-with? "./" name)
    (setq name (substring name 2)))
  (when (or (s-starts-with? ":" name) (s-starts-with? "/" name))
    (setq name (substring name 1)))
  (when (s-ends-with? "," name)
    (setq name (substring name 0 -1)))
  name)

(defun projectile-ember-sanitize-dir-name (name)
  (if (s-ends-with? "/" name) name (concat name "/")))

(defun projectile-ember-current-line ()
  (save-excursion
    (let (beg)
      (beginning-of-line)
      (setq beg (point))
      (end-of-line)
      (buffer-substring-no-properties beg (point)))))

(defun projectile-ember-set-assets-dirs ()
  (setq-local
   projectile-ember-javascript-dirs
   (--filter (file-exists-p (projectile-expand-root it)) projectile-ember-javascript-dirs))
  (setq-local
   projectile-ember-stylesheet-dirs
   (--filter (file-exists-p (projectile-expand-root it)) projectile-ember-stylesheet-dirs)))


(defun projectile-ember-set-fixture-dirs ()
  (setq-local
   projectile-ember-fixture-dirs
   (--filter (file-exists-p (projectile-expand-root it)) projectile-ember-fixture-dirs)))

(defvar projectile-ember-mode-goto-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "f") 'projectile-ember-goto-file-at-point)
    (define-key map (kbd "g") 'projectile-ember-goto-gemfile)
    (define-key map (kbd "r") 'projectile-ember-goto-routes)
    (define-key map (kbd "d") 'projectile-ember-goto-schema)
    (define-key map (kbd "s") 'projectile-ember-goto-seeds)
    (define-key map (kbd "h") 'projectile-ember-goto-spec-helper)
    map)
  "A goto map for `projectile-ember-mode'.")
(fset 'projectile-ember-mode-goto-map projectile-ember-mode-goto-map)

(defvar projectile-ember-mode-run-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "c") 'projectile-ember-console)
    (define-key map (kbd "s") 'projectile-ember-server)
    (define-key map (kbd "r") 'projectile-ember-rake)
    (define-key map (kbd "g") 'projectile-ember-generate)
    (define-key map (kbd "d") 'projectile-ember-destroy)
    map)
  "A run map for `projectile-ember-mode'.")
(fset 'projectile-ember-mode-run-map projectile-ember-mode-run-map)

(defvar projectile-ember-command-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "m") 'projectile-ember-find-model)
    (define-key map (kbd "M") 'projectile-ember-find-current-model)

    (define-key map (kbd "c") 'projectile-ember-find-controller)
    (define-key map (kbd "C") 'projectile-ember-find-current-controller)

    (define-key map (kbd "v") 'projectile-ember-find-view)
    (define-key map (kbd "V") 'projectile-ember-find-current-view)

    (define-key map (kbd "j") 'projectile-ember-find-javascript)
    (define-key map (kbd "J") 'projectile-ember-find-current-javascript)

    (define-key map (kbd "s") 'projectile-ember-find-stylesheet)
    (define-key map (kbd "S") 'projectile-ember-find-current-stylesheet)

    (define-key map (kbd "h") 'projectile-ember-find-helper)
    (define-key map (kbd "H") 'projectile-ember-find-current-helper)

    (define-key map (kbd "p") 'projectile-ember-find-spec)
    (define-key map (kbd "P") 'projectile-ember-find-current-spec)

    (define-key map (kbd "t") 'projectile-ember-find-test)
    (define-key map (kbd "T") 'projectile-ember-find-current-test)

    (define-key map (kbd "n") 'projectile-ember-find-migration)
    (define-key map (kbd "N") 'projectile-ember-find-current-migration)

    (define-key map (kbd "r") 'projectile-ember-console)
    (define-key map (kbd "R") 'projectile-ember-server)

    (define-key map (kbd "u") 'projectile-ember-find-fixture)
    (define-key map (kbd "U") 'projectile-ember-find-current-fixture)

    (define-key map (kbd "l") 'projectile-ember-find-lib)
    (define-key map (kbd "f") 'projectile-ember-find-feature)
    (define-key map (kbd "i") 'projectile-ember-find-initializer)
    (define-key map (kbd "o") 'projectile-ember-find-log)
    (define-key map (kbd "e") 'projectile-ember-find-environment)
    (define-key map (kbd "a") 'projectile-ember-find-locale)
    (define-key map (kbd "@") 'projectile-ember-find-mailer)
    (define-key map (kbd "y") 'projectile-ember-find-layout)
    (define-key map (kbd "k") 'projectile-ember-find-rake-task)

    (define-key map (kbd "x") 'projectile-ember-extract-region)
    (define-key map (kbd "RET") 'projectile-ember-goto-file-at-point)

    (define-key map (kbd "g") 'projectile-ember-mode-goto-map)
    (define-key map (kbd "!") 'projectile-ember-mode-run-map)
    map)
  "Keymap after `projectile-ember-keymap-prefix'.")
(fset 'projectile-ember-command-map projectile-ember-command-map)

(defvar projectile-ember-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map projectile-ember-keymap-prefix 'projectile-ember-command-map)
    map)
  "Keymap for `projectile-ember-mode'.")

(easy-menu-define projectile-ember-menu projectile-ember-mode-map
  "Menu for `projectile-ember-mode'."
  '("Ember"
    ["Find model"               projectile-ember-find-model]
    ["Find controller"          projectile-ember-find-controller]
    ["Find view"                projectile-ember-find-view]
    ["Find javascript"          projectile-ember-find-javascript]
    ["Find stylesheet"          projectile-ember-find-stylesheet]
    ["Find helper"              projectile-ember-find-helper]
    ["Find spec"                projectile-ember-find-spec]
    ["Find test"                projectile-ember-find-test]
    ["Find feature"             projectile-ember-find-feature]
    ["Find migration"           projectile-ember-find-migration]
    ["Find fixture"             projectile-ember-find-fixture]
    ["Find lib"                 projectile-ember-find-lib]
    ["Find initializer"         projectile-ember-find-initializer]
    ["Find environment"         projectile-ember-find-environment]
    ["Find log"                 projectile-ember-find-log]
    ["Find locale"              projectile-ember-find-locale]
    ["Find mailer"              projectile-ember-find-mailer]
    ["Find layout"              projectile-ember-find-layout]
    ["Find rake task"           projectile-ember-find-rake-task]
    "--"
    ["Go to file at point"      projectile-ember-goto-file-at-point]
    "--"
    ["Go to Gemfile"            projectile-ember-goto-gemfile]
    ["Go to routes"             projectile-ember-goto-routes]
    ["Go to schema"             projectile-ember-goto-schema]
    ["Go to seeds"              projectile-ember-goto-seeds]
    ["Go to spec helper"        projectile-ember-goto-spec-helper]
    "--"
    ["Go to current model"      projectile-ember-find-current-model]
    ["Go to current controller" projectile-ember-find-current-controller]
    ["Go to current view"       projectile-ember-find-current-view]
    ["Go to current javascript" projectile-ember-find-current-javascript]
    ["Go to current stylesheet" projectile-ember-find-current-stylesheet]
    ["Go to current spec"       projectile-ember-find-current-spec]
    ["Go to current test"       projectile-ember-find-current-test]
    ["Go to current migration"  projectile-ember-find-current-migration]
    ["Go to current fixture"    projectile-ember-find-current-fixture]
    "--"
    ["Extract to partial"       projectile-ember-extract-region]
    "--"
    ["Run console"              projectile-ember-console]
    ["Run server"               projectile-ember-server]
    ["Run rake"                 projectile-ember-rake]
    ["Run ember generate"       projectile-ember-generate]
    ["Run ember destroy"        projectile-ember-destroy]))

;;;###autoload
(define-minor-mode projectile-ember-mode
  "Ember mode based on projectile"
  :init-value nil
  :lighter " Ember"
  (when projectile-ember-mode
    (and projectile-ember-expand-snippet (projectile-ember-expand-snippet-maybe))
    (and projectile-ember-add-keywords (projectile-ember-add-keywords-for-file-type))
    (projectile-ember-set-assets-dirs)
    (projectile-ember-set-fixture-dirs)))

;;;###autoload
(defun projectile-ember-on ()
  "Enable `projectile-ember-mode' minor mode if this is a ember project."
  (when (and
         (not (projectile-ember--ignore-buffer-p))
         (projectile-ember-root))
    (projectile-ember-mode +1)))

(defun projectile-ember-off ()
  "Disable `projectile-ember-mode' minor mode."
  (projectile-ember-mode -1))

(define-derived-mode projectile-ember-server-mode compilation-mode "Projectile Ember Server"
  "Compilation mode for running ember server used by `projectile-ember'.

Killing the buffer will terminate to server's process."
  (set (make-local-variable 'compilation-error-regexp-alist) (list 'ruby-Test::Unit))
  (add-hook 'compilation-filter-hook 'projectile-ember-server-make-buttons nil t)
  (when projectile-ember-server-mode-ansi-colors
    (add-hook 'compilation-filter-hook 'projectile-ember-apply-ansi-color nil t))
  (add-hook 'kill-buffer-hook 'projectile-ember-server-terminate t t)
  (add-hook 'kill-emacs-hook 'projectile-ember-server-terminate t t)
  (setq-local compilation-scroll-output t)
  (projectile-ember-mode +1))

(define-derived-mode projectile-ember-compilation-mode compilation-mode "Projectile Ember Compilation"
  "Compilation mode used by `projectile-ember'."
  (add-hook 'compilation-filter-hook 'projectile-ember-apply-ansi-color nil t)
  (projectile-ember-mode +1))

(define-derived-mode projectile-ember-generate-mode projectile-ember-compilation-mode "Projectile Ember Generate"
  "Mode for output of ember generate."
  (add-hook 'compilation-finish-functions 'projectile-ember--generate-buffer-make-buttons nil t)
  (projectile-ember-mode +1))

(when (functionp 'discover-add-context-menu)

  (defun projectile-ember--discover-find-submenu ()
    (interactive)
    (call-interactively
     (discover-get-context-menu-command-name 'projectile-ember-find)))

  (defun projectile-ember--discover-goto-submenu ()
    (interactive)
    (call-interactively
     (discover-get-context-menu-command-name 'projectile-ember-goto)))

  (defun projectile-ember--discover-run-submenu ()
    (interactive)
    (call-interactively
     (discover-get-context-menu-command-name 'projectile-ember-run)))

  (discover-add-context-menu
   :context-menu '(projectile-ember-mode
                   (description "Mode for Ember projects")
                   (actions
                    ("Available"
                     ("f" "find resources"   projectile-ember--discover-find-submenu)
                     ("g" "goto resources"   projectile-ember--discover-goto-submenu)
                     ("r" "run and interact" projectile-ember--discover-run-submenu))))
   :bind projectile-ember-discover-bind
   :mode 'projectile-ember
   :mode-hook 'projectile-ember-mode-hook)

  (discover-add-context-menu
   :context-menu '(projectile-ember-find
                   (description "Find resources")
                   (actions
                    ("Find a resource"
                     ("m" "model"       projectile-ember-find-model)
                     ("v" "view"        projectile-ember-find-view)
                     ("c" "controller"  projectile-ember-find-controller)
                     ("h" "helper"      projectile-ember-find-helper)
                     ("l" "lib"         projectile-ember-find-lib)
                     ("j" "javascript"  projectile-ember-find-javascript)
                     ("s" "stylesheet"  projectile-ember-find-stylesheet)
                     ("p" "spec"        projectile-ember-find-spec)
                     ("u" "fixture"     projectile-ember-find-fixture)
                     ("t" "test"        projectile-ember-find-test)
                     ("f" "feature"     projectile-ember-find-feature)
                     ("i" "initializer" projectile-ember-find-initializer)
                     ("o" "log"         projectile-ember-find-log)
                     ("@" "mailer"      projectile-ember-find-mailer)
                     ("y" "layout"      projectile-ember-find-layout)
                     ("n" "migration"   projectile-ember-find-migration)
                     ("k" "rake task"   projectile-ember-find-rake-task))
                    ("Find an associated resource"
                     ("M" "model"       projectile-ember-find-current-model)
                     ("V" "view"        projectile-ember-find-current-view)
                     ("C" "controller"  projectile-ember-find-current-controller)
                     ("H" "helper"      projectile-ember-find-current-helper)
                     ("J" "javascript"  projectile-ember-find-current-javascript)
                     ("S" "stylesheet"  projectile-ember-find-current-stylesheet)
                     ("P" "spec"        projectile-ember-find-current-spec)
                     ("U" "fixture"     projectile-ember-find-current-fixture)
                     ("T" "test"        projectile-ember-find-current-test)
                     ("N" "migration"   projectile-ember-find-current-migration))))
   :bind "") ;;accessible only from the main context menu

  (discover-add-context-menu
   :context-menu '(projectile-ember-goto
                   (description "Go to a specific file")
                   (actions
                    ("Go to"
                     ("f" "file at point" projectile-ember-goto-file-at-point)
                     ("g" "Gemfile"       projectile-ember-goto-gemfile)
                     ("r" "routes"        projectile-ember-goto-routes)
                     ("d" "schema"        projectile-ember-goto-schema)
                     ("s" "seeds"         projectile-ember-goto-seeds)
                     ("h" "spec helper"   projectile-ember-goto-spec-helper))))
   :bind "") ;;accessible only from the main context menu

  (discover-add-context-menu
   :context-menu '(projectile-ember-run
                   (description "Run and interact")
                   (actions
                    ("Run external command"
                     ("r" "rake"           projectile-ember-rake)
                     ("c" "console"        projectile-ember-console)
                     ("s" "server"         projectile-ember-server)
                     ("g" "generate"       projectile-ember-generate)
                     ("d" "destroy"        projectile-ember-destroy))
                    ("Interact"
                     ("x" "extract region" projectile-ember-extract-region))))
   :bind "") ;;accessible only from the main context menu
  )

(provide 'init-projectile-ember)

;;; projectile-ember.el ends here
