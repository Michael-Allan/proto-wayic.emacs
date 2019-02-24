;; A major mode for editing Wayscript.
;;
;; Usage for your Emacs configuration file:
;;
;;    (require 'wayscript-mode)
;;    (add-to-list 'auto-mode-alist '("/waycast/.+\\.xht$" . wayscript-mode))
;;
;; Working example:
;;     http://reluk.ca/.emacs
;;     http://reluk.ca/.Xresources
;;
;; Screen shot of the result, showing the font locking:
;; http://reluk.ca/project/wayic/emacs/screen_shot.png


(define-derived-mode wayscript-mode html-mode
  "Wayscript"
  "Major mode for editing Wayscript"
  (font-lock-add-keywords nil
    ;;; Use of *font-lock-defaults* might be preferable.  See however the related notes
    ;;; in http://reluk.ca/sys/host/havoc/usr/local/share/emacs/site-lisp/js-mca-mode.el
   '(
     ;; Composer
     ;; --------
     ("\\(<\\)way:\\(group\\)\\>\\(?:[^>\n]*> *\\([^<\n]+\\)\\)?"
      ;;  '''''''''''''''''ST''''''''''''''''     '''Q'''
      ;; ST  start tag
      ;;  Q  qualifying text
      (1 'wayscript-bracketing-face t) (2 'wayscript-group-face)
      (3 'wayscript-qualifying-text-face nil t))
     ("</way:group\\(>\\)" 1 'wayscript-bracketing-face t) ; End tag

     ;; HTML inclusion
     ;; --------------
     ("<html:\\([_[:alpha:]][-._[:alnum:]]*\\)[ >\n]" 1 'wayscript-html-face t) ; Start tag name

     ;; Referential jointer
     ;; -------------------
     (             " \\(id\\) *= *\\(['\"]\\) *[_[:alpha:]][-._[:alnum:]]* *\\2" 1 'wayscript-top-face t)
     (" way:\\(join\\) *= *\\(['\"]\\)[^\n]*#[_[:alpha:]][-._[:alnum:]]* *\\2" 1 'wayscript-top-face t)

     ;; Waybit
     ;; ------
     ("<\\([_[:alpha:]][-._[:alnum:]]*\\)[ >\n]" 1 'wayscript-bit-face t) ; Start tag name

     ;; Waybit: Commitment jointer  (probable, root)
     ;; --------------------------
     ("<\\([_[:alpha:]][-._[:alnum:]]*\\) [^>\n]*\\bway:join *= *\\(['\"]\\) *\\(/way\.xht#resolve\\) *\\2"
      1 'wayscript-commitment-face t)

     ;; Waybit: Step
     ;; ------------
     ("<\\(step\\):\\(?:\\(_\\)\\|\\([_[:alpha:]][-._[:alnum:]]*\\)\\)\\(?:[ >\n]\\|/>\\)" ; Prefixed
      (1 'wayscript-step-face t) (2 font-lock-comment-face t t) (3 'wayscript-step-accent-face t t))
     ("<\\([_[:alpha:]][-._[:alnum:]]*\\) [^>\n]*\\bxmlns=\\(['\"]\\) *data:,wayscript\\.bit\\.step *\\2"
      (1 'wayscript-step-face t)) ; Unprefixed singleton

     )
   )
  )



;; You will want to customize these faces.  The defaults below are not very good.
;; Working example of customization: http://reluk.ca/.Xresources
(defface wayscript-bit-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for the start tag of waybits."
  :group 'basic-faces)
(defface wayscript-bracketing-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for the bracketing of *group* elements."
  :group 'basic-faces)
(defface wayscript-commitment-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for the start tag of commitment jointers."
  :group 'basic-faces)
(defface wayscript-group-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for the start tag of *group* elements."
  :group 'basic-faces)
(defface wayscript-html-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for the start tag of embeddable HTML elements."
  :group 'basic-faces)
(defface wayscript-qualifying-text-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for the qualifying text of *group* elements."
  :group 'basic-faces)
(defface wayscript-step-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for the start tag of steps."
  :group 'basic-faces)
(defface wayscript-step-accent-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for accents within steps."
  :group 'basic-faces)
(defface wayscript-top-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for attributes in the top namespace of Wayscript proper."
    ;;; § Namespacing § hierarchy, http://reluk.ca/project/wayic/script/doc.task
  :group 'basic-faces)



(provide 'wayscript-mode)



;; Copyright © 2017-2018 Michael Allan and contributors.  Licence MIT.
