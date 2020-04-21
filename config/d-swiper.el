(defun d-swiper-init ()
  ;; TODO Make ESC and C-[ quit
  ;; TODO Integrate swiper with evil-search (let evil know what we searched for
  ;; with swiper so that when we go back to normal mode, "n" and "N" work as if
  ;; we used evil-search-*)
  (evil-leader/set-key "/" 'swiper))

(use-package swiper
  :ensure t
  :init (d-swiper-init))

(provide 'd-swiper)
