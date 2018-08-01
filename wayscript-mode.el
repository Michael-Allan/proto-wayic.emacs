;; A major mode for editing wayscript.
;;
;; Usage for your .emacs configuration file:
;;
;;    (require 'wayscript-mode)
;;    (add-to-list 'auto-mode-alist '("/way\\.xht$" . wayscript-mode))
;;
;; Working example:
;;     http://reluk.ca/.emacs
;;     http://reluk.ca/.Xresources
;;
;; Screen shot of font locking: http://reluk.ca/project/wayic/emacs/screen_shot.png


(define-derived-mode wayscript-mode html-mode
  "wayscript"
  "Major mode for editing XHTML wayscript"
  (font-lock-add-keywords nil
    ;;; Use of *font-lock-defaults* might be preferable.  See however the related notes
    ;;; in http://reluk.ca/sys/host/havoc/usr/local/share/emacs/site-lisp/js-mca-mode.el
   '(
     ;; Composer
     ;; --------
     ("\\(<\\)cog:\\(group\\)\\>\\(?:[^>\n]*> *\\([^<\n]+\\)\\)?"
      ;;  '''''''''''''''''ST''''''''''''''''     '''Q'''
      ;; ST  start tag
      ;;  Q  qualifying text
      (1 'wayscript-bracketing-face t)(2 'wayscript-group-face)
      (3 'wayscript-qualifying-text-face nil t))
     ("</cog:group\\(>\\)" 1 'wayscript-bracketing-face t) ; end tag

     ;; HTML inclusion
     ;; --------------
     ("<html:\\([_[:alpha:]][-._[:alnum:]]*\\)[ >\n]" 1 'wayscript-html-face t) ; start tag name

     ;; Waybit
     ;; ------
     ("<\\([_[:alpha:]][-._[:alnum:]]*\\)[ >\n]" 1 'wayscript-bit-face t) ; start tag name

     ;; Waybit: Commitment declaration
     ;; ------------------------------
     ("<\\([_[:alpha:]][-._[:alnum:]]*\\) [^>\n]*\\bcog:link *= *\\(['\"]\\) *\\(/#commitment\\)\\2"
      1 'wayscript-commitment-face t)

     ;; Waybit: Step
     ;; ------------
     ("<\\(step\\):\\(?:\\(_\\)\\|\\([_[:alpha:]][-._[:alnum:]]*\\)\\)\\(?:[ >\n]\\|/>\\)" ; prefixed
      (1 'wayscript-step-face t)(2 font-lock-comment-face t t)(3 'wayscript-step-accent-face t t))
     ("<\\([_[:alpha:]][-._[:alnum:]]*\\) [^>\n]*\\bxmlns=\\(['\"]\\)data:,wayscript\\.bit\\.step\\2"
      (1 'wayscript-step-face t)) ; unprefixed singleton

     ;; Waylink
     ;; -------
     (             " \\(id\\) *= *\\(['\"]\\)[_[:alpha:]][-._[:alnum:]]*\\2" 1 'wayscript-cog-face t)
     (" cog:\\(link\\) *= *\\(['\"]\\)[^\n]*#[_[:alpha:]][-._[:alnum:]]*\\2" 1 'wayscript-cog-face t)

     )
   )
  )



;; You'll want to customize these faces.  The defaults below aren't very good.
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
(defface wayscript-cog-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for *cog* attributes."
  :group 'basic-faces)
(defface wayscript-commitment-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for the start tag of commitment declarations."
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



(provide 'wayscript-mode)



;; Copyright © 2017-2018 Michael Allan and contributors.  Licence MIT.
