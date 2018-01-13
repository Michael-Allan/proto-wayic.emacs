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
   '(
     ;; Cog
     ;; ---
     ("<cog:\\(cast\\)[ >\n]" 1 'wayscript-cog-face t t)
     (" cog:\\(lid\\) *= *\\(['\"]\\)[_[:alpha:]][-._[:alnum:]]*\\2" 1 'wayscript-cog-face t)
     (" cog:\\(link\\) *= *\\(['\"]\\)[^\n]*#[_[:alpha:]][-._[:alnum:]]*\\2" 1 'wayscript-cog-face t)

     ;; Cog composer
     ;; ------------
     ("\\(<\\)cog:\\(comprising\\|including\\)\\>\\(?:[^>\n]*> *\\([^<\n]+\\)\\)?"
      ;;  ''''''''''''''''''''''''''ST''''''''''''''''''''''''     '''Q'''
      ;; ST  start tag
      ;;  Q  qualifying text
      (1 'wayscript-deprecated-face t)(2 'wayscript-html-face)(3 'wayscript-html-face nil t))
     ("</cog:\\(?:comprising\\|including\\)\\(>\\)" 1 'wayscript-deprecated-face t) ; end tag

     ;; HTML inclusion
     ;; --------------
     ("<html:\\([_[:alpha:]][-._[:alnum:]]*\\)[ >\n]" 1 'wayscript-html-face t) ; start tag name

     ;; Waybit
     ;; ------
     ("<\\([_[:alpha:]][-._[:alnum:]]*\\)[ >\n]" 1 'wayscript-bit-face t) ; start tag name

     ;; Waybit commitment
     ;; -----------------
     ("<\\([_[:alpha:]][-._[:alnum:]]*\\) [^>\n]*\\bcog:link *= *\\(['\"]\\) *\\(/actor/#commitment\\)\\2"
      1 'wayscript-commitment-face t)

     ;; Waybit step
     ;; -----------
     ("<\\(step\\):\\(?:\\(_\\)\\|\\([_[:alpha:]][-._[:alnum:]]*\\)\\)\\(?:[ >\n]\\|/>\\)" ; prefixed
      (1 'wayscript-step-face t)(2 font-lock-comment-face t t)(3 'wayscript-step-accent-face t t))
     ("<\\([_[:alpha:]][-._[:alnum:]]*\\) [^>\n]*\\bxmlns=\\(['\"]\\)data:,wayscript\\.bit\\.step\\2"
      (1 'wayscript-step-face t)) ; unprefixed singleton

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
  "Wayscript face for waybit elements."
  :group 'basic-faces)
(defface wayscript-cog-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for cog elements and attributes."
  :group 'basic-faces)
(defface wayscript-commitment-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for waylink source nodes that target a commitment to act."
  :group 'basic-faces)
(defface wayscript-deprecated-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "A wayscript face that's slated for removal."
  :group 'basic-faces)
(defface wayscript-html-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for embeddable HTML elements."
  :group 'basic-faces)
(defface wayscript-step-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for step elements."
  :group 'basic-faces)
(defface wayscript-step-accent-face
  '((((type tty pc) (class color) (background light)) (:foreground "red"))
    (((type tty pc) (class color) (background dark)) (:foreground "red1"))
    (((class grayscale) (background light)) (:foreground "DimGray" :bold t :italic t))
    (((class grayscale) (background dark)) (:foreground "LightGray" :bold t :italic t))
    (((class color) (background light)) (:foreground "rgb:FF/00/00"))
    (((class color) (background dark)) (:foreground "rgb:FF/00/00"))
    (t (:bold t :italic t)))
  "Wayscript face for accents within step elements."
  :group 'basic-faces)



(provide 'wayscript-mode)



;; Copyright © 2017 Michael Allan and contributors.  Licence MIT.
