(require 'package)

(setq package-archives '(("org" . "https://orgmode.org/elpa/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (file-directory-p "~/.emacs.d/lisp/")
  (make-directory "~/.emacs.d/lisp"))

(unless (file-directory-p "~/.emacs.d/lisp/org-mode")
    (shell-command (concat "cd ~/.emacs.d/lisp && "
                           "git clone "
                           "--branch release_9.4.5 "
                           "https://code.orgmode.org/bzg/org-mode.git && "
                           "cd org-mode && make all")))

(let ((default-directory  "~/.emacs.d/lisp/"))
  (setq load-path
        (append
         (let ((load-path (copy-sequence load-path)))
           (normal-top-level-add-to-load-path '("org-mode/lisp"
                                                "org-mode/contrib/lisp")))
         load-path)))

(unless (file-directory-p "~/.emacs.d/lisp/ob-julia")
    (shell-command (concat "cd ~/.emacs.d/lisp && "
                           "git clone "
                           "--branch v0.0.1 "
                           "https://github.com/phrb/ob-julia.git && "
                           "cd ob-julia && make all")))

(if (file-directory-p "~/.emacs.d/lisp/ob-julia")
    (let ((default-directory  "~/.emacs.d/lisp/"))
      (setq load-path
            (append
             (let ((load-path (copy-sequence load-path)))
               (normal-top-level-add-to-load-path '("ob-julia")))
             load-path))))

(if (file-directory-p "~/.emacs.d/lisp/org-bullets")
    (let ((default-directory  "~/.emacs.d/lisp/"))
      (setq load-path
            (append
             (let ((load-path (copy-sequence load-path)))
               (normal-top-level-add-to-load-path '("org-bullets")))
             load-path))))

(if (file-directory-p "~/.emacs.d/lisp/org2jekyll")
    (let ((default-directory  "~/.emacs.d/lisp/"))
      (setq load-path
            (append
             (let ((load-path (copy-sequence load-path)))
               (normal-top-level-add-to-load-path '("org2jekyll")))
             load-path))))

(unless package-archive-contents
  (package-refresh-contents))

(setq pkg-deps '(graphviz-dot-mode
                 ebib
                 magit
                 cuda-mode
                 doom-modeline
                 doom-themes
                 all-the-icons
                 rust-mode
                 dockerfile-mode
                 lua-mode
                 ace-window
                 jupyter
                 yaml-mode
                 markdown-mode
                 aggressive-indent
                 counsel
                 ess
                 swiper
                 kv
                 which-key
                 s
                 powerline
                 julia-mode
                 ivy
                 evil
                 deferred
                 dash-functional
                 base16-theme))

(dolist (pkg pkg-deps)
  (unless (package-installed-p pkg)
    (package-install pkg)))

(savehist-mode 1)
(desktop-save-mode 1)

(setq-default desktop-save t)
(setq-default desktop-auto-save-timeout 10)

(setq-default buffer-file-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setq-default indent-tabs-mode nil)

(save-place-mode 1)
(setq save-place-forget-unreadable-files nil)

(global-auto-revert-mode t)

(defvar backup-directory (concat user-emacs-directory "backups/"))
(defvar autosave-directory (concat user-emacs-directory "autosave/"))

(if (not (file-exists-p backup-directory)) (make-directory backup-directory t))
(if (not (file-exists-p autosave-directory)) (make-directory autosave-directory t))

(setq backup-directory-alist `((".*" . ,backup-directory)))
(setq auto-save-file-name-transforms `((".*" ,autosave-directory t)))

(setq make-backup-files t)
(setq auto-save-default t)
(setq auto-save-timeout 45)

(setq create-lockfiles nil)

(setq auto-save-interval 300)

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file)

(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "firefox")

(setq-default fill-column 80)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(defalias 'yes-or-no-p 'y-or-n-p)

(add-to-list 'auto-mode-alist '("\.cu$" . c++-mode))

(setq inhibit-splash-screen t)

(require 'base16-theme)
(load-theme 'base16-default-dark t)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(set-fringe-mode 0)

(add-to-list 'default-frame-alist '(font . "Liberation Mono-13" ))
(set-face-attribute 'default t :font "Liberation Mono-13" )

(blink-cursor-mode 0)

(setq scroll-step 1)
(setq scroll-conservatively  10000)
(setq auto-window-vscroll nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(show-paren-mode 1)

(setq-default c-default-style "linux"
              c-basic-offset 4)

(add-hook 'prog-mode-hook 'linum-mode)

(require 'doom-modeline)
(doom-modeline-mode 1)
(setq doom-modeline-height 1)
(set-face-attribute 'mode-line nil :family "Liberation Mono" :height 110)
(set-face-attribute 'mode-line-inactive nil :family "Liberation Mono" :height 110)

(require 'all-the-icons)

(require 'evil)
(evil-mode 1)
(setq evil-want-Y-yank-to-eol nil)

(defvar my/base16-colors base16-default-dark-colors)
(setq evil-emacs-state-cursor   `(,(plist-get my/base16-colors :base0D) box))
(setq evil-insert-state-cursor  `(,(plist-get my/base16-colors :base0D) box))
(setq evil-motion-state-cursor  `(,(plist-get my/base16-colors :base0E) box))
(setq evil-normal-state-cursor  `(,(plist-get my/base16-colors :base0B) box))
(setq evil-replace-state-cursor `(,(plist-get my/base16-colors :base08) box))
(setq evil-visual-state-cursor  `(,(plist-get my/base16-colors :base09) box))

(require 'which-key)
(which-key-mode)

(require 'org)

(setq org-link-file-path-type 'relative)

(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(setq org-startup-with-inline-images nil)
;; (setq org-image-actual-width nil)

;; (setq org-hide-emphasis-markers t)
(setq org-hide-emphasis-markers nil)

(setq org-descriptive-links nil)

;; (setq org-pretty-entities t)
(setq org-pretty-entities nil)

(setq org-html-htmlize-output-type (quote css))

(setq org-cycle-separator-lines 0)

(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
      `(
        ("p" "Personal task")
        ("pp" "No deadline, no reminder" entry
         (file+olp+datetree ,(concat org-directory "/tasks/tasks.org") "Personal")
         ,(concat "* TODO %? :personal:"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :tree-type day :jump-to-captured nil :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("pd" "With a deadline" entry
         (file+olp+datetree ,(concat org-directory "/tasks/tasks.org") "Personal")
         ,(concat "* TODO %? :personal:"
                  "\nDEADLINE: %^{Task deadline}t"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :tree-type day :jump-to-captured nil :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("pt" "No deadline, with reminder" entry
         (file+olp+datetree ,(concat org-directory "/tasks/tasks.org") "Personal")
         ,(concat "* TODO %? :personal:"
                  "\n%^{Remind me on}t"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :tree-type day :jump-to-captured nil :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("w" "Work task")
        ("ww" "No deadline, no reminder" entry
         (file+olp+datetree ,(concat org-directory "/tasks/tasks.org") "Work")
         ,(concat "* TODO %? :work:"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :tree-type day :jump-to-captured nil :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("wd" "With a deadline" entry
         (file+olp+datetree ,(concat org-directory "/tasks/tasks.org") "Work")
         ,(concat "* TODO %? :work:"
                  "\nDEADLINE: %^{Task deadline}t"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :tree-type day :jump-to-captured nil :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("wt" "No deadline, with reminder" entry
         (file+olp+datetree ,(concat org-directory "/tasks/tasks.org") "Work")
         ,(concat "* TODO %? :work:"
                  "\n%^{Remind me on}t"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :tree-type day :jump-to-captured nil :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("e" "Enough item" entry
         (file+olp+datetree ,(concat org-directory "/tasks/tasks.org") "Enough")
         ,(concat "* TODO %? :enough:"
                  "\nSCHEDULED: %^{Schedule task to}t"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :tree-type day :jump-to-captured nil :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("j" "Journal entry")
        ("jj" "General journal entry" entry
         (file+olp+datetree ,(concat org-directory "/journal/journal.org"))
         ,(concat "* %? %^G"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :jump-to-captured t :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("jl" "Lux linux journal entry" entry
         (file+olp+datetree ,(concat org-directory "/luxlinux/journal.org") "Journal")
         ,(concat "* %? %^G"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :jump-to-captured t :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("m" "Meeting")
        ("mm" "Record notes (general)" entry
         (file+olp+datetree ,(concat org-directory "/journal/journal.org"))
         ,(concat "* %? %^G:meeting:"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :jump-to-captured t :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("ma" "Make an appointment" entry
         (file+olp+datetree ,(concat org-directory "/tasks/tasks.org") "Meetings")
         ,(concat "* TODO %? %^G:meeting:"
                  "\n%^{Schedule meeting to}t"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :jump-to-captured nil :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("ml" "Record Lux notes" entry
         (file+olp+datetree ,(concat org-directory "/luxlinux/journal.org") "Meetings")
         ,(concat "* %? %^G:meeting:"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :jump-to-captured t :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("t" "Teaching")
        ("ta" "Make an appointment" entry
         (file+olp+datetree ,(concat org-directory "/tasks/tasks.org") "Teaching")
         ,(concat "* TODO %? %^G:teaching:"
                  "\n%^{Schedule class to}t"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :jump-to-captured nil :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("tn" "Record notes" entry
         (file+olp+datetree ,(concat org-directory "/journal/journal.org"))
         ,(concat "* %? %^G:teaching:"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n%i\n")
         :jump-to-captured t :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("b" "Bibliographic entry")
        ("bb" "Reference" entry
         (file+olp+datetree ,(concat org-directory "/bibliography/bibliography.org")
                            "References")
         ,(concat "* %? %^G:bib:"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n\n"
                  "** Notes\n\n"
                  "** Bibtex\n\n"
                  "#+begin_src bibtex :tangle \"references.bib\"\n"
                  "@article{}\n"
                  "#+end_src\n%i\n")
         :jump-to-captured nil :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ("br" "Reading list" entry
         (file+olp+datetree ,(concat org-directory "/bibliography/bibliography.org")
                                     "References")
         ,(concat "* TODO %? %^G:bib:"
                  "\n:PROPERTIES:"
                  "\n:CAPTURED: %U"
                  "\n:END:\n\n"
                  "** Notes\n\n"
                  "** Bibtex\n\n"
                  "#+begin_src bibtex :tangle \"references.bib\"\n"
                  "@article{}\n"
                  "#+end_src\n%i\n")
         :jump-to-captured nil :empty-lines-after 1
         :empty-lines-before 0 :unnarrowed nil)
        ))

(setq org-agenda-files (list "/home/phrb/org/tasks"
                             "/home/phrb/org/journal"
                             "/home/phrb/org/bibliography"))

(setq org-agenda-restore-windows-after-quit t)

(global-set-key (kbd "C-c a") 'org-agenda)

(setq org-agenda-custom-commands
      '(("w" "Agenda and work tasks"
         ((agenda "")
          (tags-todo "work")))
        ("b" "Agenda, work, and bib tasks"
         ((agenda "")
          (tags-todo "work")
          (tags-todo "bib")
          (tags-todo "reading")))
        ("p" "Agenda and personal tasks"
         ((agenda "")
          (tags-todo "personal")))))

(setq org-latex-with-hyperref nil)

(require 'ox-latex)

;; Change for beamer
;;(setq org-latex-pdf-process (list "latexmk -xelatex %f"))

;; (setq org-latex-pdf-process (list "latexmk -pdflatex='pdflatex' -pdf -f %f"))
(setq org-latex-pdf-process (list "latexmk -pdflatex='pdflatex -interaction nonstopmode -output-directory %o %f' -pdf -f %f -output-directory=%o"))
(setq org-latex-default-packages-alist nil)
(setq org-latex-packages-alist (quote (("" "booktabs" t))))

(setq org-latex-listings t)
(add-to-list 'org-latex-classes
             '("org-elsarticle"
               "\\documentclass{elsarticle}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
             '("org-ieeetran"
               "\\documentclass{IEEEtran}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
           '("partless-book"
              "\\documentclass{book}"
              ("\\chapter{%s}" . "\\chapter{%s}")
              ("\\section{%s}" . "\\section*{%s}")
              ("\\subsection{%s}" . "\\subsection*{%s}")
              ("\\paragraph{%s}" . "\\paragraph*{%s}")
              )
)

(setq org-latex-prefer-user-labels t)

(setq org-latex-listings 'minted)

(require 'ox-md)

(require 'ox-odt)

(setq org-edit-src-auto-save-idle-delay 5)
(setq org-edit-src-content-indentation 0)
(setq org-src-fontify-natively t)
(setq org-src-window-setup (quote other-window))
(setq org-confirm-babel-evaluate nil)

(require 'org-tempo)

(setq org-babel-default-header-args
      '((:session . "none")
	(:results . "output replace")
	(:exports . "results")
	(:cache . "no")
	(:noweb . "yes")
	(:hlines . "no")
	(:tangle . "no")
        (:eval . "no-export")
	(:padnewline . "yes")))

(setq org-babel-default-header-args:R
      '((:session . "*R*")))

(setq org-babel-default-header-args:bash
      '((:session . "*Shell*")))

(setq org-babel-default-header-args:python
      '((:session . "*Python*")))

(add-to-list 'org-structure-template-alist
             '("eI" . "SRC emacs-lisp :tangle init.el"))
(add-to-list 'org-structure-template-alist
             '("Sh" . "SRC shell"))
(add-to-list 'org-structure-template-alist
             '("Sb" . "SRC bash"))
(add-to-list 'org-structure-template-alist
             '("b" . "SRC bibtex :tangle ./bib/references.bib"))
(add-to-list 'org-structure-template-alist
             '("j" . "SRC julia"))
(add-to-list 'org-structure-template-alist
             '("p" . "SRC python"))
(add-to-list 'org-structure-template-alist
             '("r" . "SRC R"))
(add-to-list 'org-structure-template-alist
             '("g" . "SRC R :results file graphics output :file \".pdf\" :width 10 :height 10 :eval no-export"))
(add-to-list 'org-structure-template-alist
             '("t" . "SRC latex :results output latex"))

; (require 'org-bullets)
; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;
; (setq org-bullets-bullet-list '("☯" "☢" "✜" "✚" "♠" "♣" "❀"))

(setq python-shell-completion-native-enable nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (R . t)
   (C . t)
   (julia . t)
   (python . t)
   (emacs-lisp . t)
   (shell . t)
   (ruby . t)
   (org . t)
   (makefile . t)
   (latex . t)
   (jupyter . t)
   ))

(require 'org-attach)
(setq org-link-abbrev-alist '(("att" . org-attach-expand-link)))

(require 'org2jekyll)

(setq org2jekyll-blog-author       "phrb")
(setq org2jekyll-source-directory  (expand-file-name "~/code/phrb.github.io/org"))
(setq org2jekyll-jekyll-directory  (expand-file-name "~/code/phrb.github.io"))
(setq org2jekyll-jekyll-drafts-dir "")
(setq org2jekyll-jekyll-posts-dir  "_posts/")
(setq org-publish-project-alist
      `(("page"
         :base-directory ,(org2jekyll-input-directory)
         :base-extension "org"
         ;; :publishing-directory "/ssh:user@host:~/html/notebook/"
         :publishing-directory ,(org2jekyll-output-directory)
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :section-numbers nil
         :with-toc nil
         :html-head "<link rel=\"stylesheet\" href=\"./css/style.css\" type=\"text/css\"/>"
         :html-preamble t
         :recursive t
         :make-index t
         :html-extension "html"
         :body-only t)

        ("post"
         :base-directory ,(org2jekyll-input-directory)
         :base-extension "org"
         :publishing-directory ,(org2jekyll-output-directory org2jekyll-jekyll-posts-dir)
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :section-numbers nil
         :with-toc nil
         :html-head "<link rel=\"stylesheet\" href=\"./css/style.css\" type=\"text/css\"/>"
         :html-preamble t
         :recursive t
         :make-index t
         :html-extension "html"
         :body-only t)

        ("images"
         :base-directory ,(org2jekyll-input-directory "img")
         :base-extension "jpg\\|gif\\|png"
         :publishing-directory ,(org2jekyll-output-directory "img")
         :publishing-function org-publish-attachment
         :recursive t)

        ("js"
         :base-directory ,(org2jekyll-input-directory "js")
         :base-extension "js"
         :publishing-directory ,(org2jekyll-output-directory "js")
         :publishing-function org-publish-attachment
         :recursive t)

        ("css"
         :base-directory ,(org2jekyll-input-directory "css")
         :base-extension "css\\|el"
         :publishing-directory ,(org2jekyll-output-directory "css")
         :publishing-function org-publish-attachment
         :recursive t)

        ("web" :components ("images" "js" "css"))
        )
      )

(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))

(setq ess-indent-level 4)

(require 'ivy)
(ivy-mode 1)

(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(require 'magit)
(define-key global-map (kbd "C-c g") 'magit-status)

(require 'ebib)

(global-set-key (kbd "C-c e") 'ebib)

(setq ebib-preload-bib-files '("~/cloud/papers/bibliography/references.bib"
                               "~/org/journal/bib/references.bib"))

(setq ebib-bibtex-dialect 'biblatex)
