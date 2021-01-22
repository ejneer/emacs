(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ledger-reports
   '(("bal credit cards" "ledger [[ledger-mode-flags]] -f /home/ejneer/Dropbox/Orgzly/finances.ledger bal \"credit cards\" --cleared")
     ("assets + liabilities ($ basis)" "ledger -V -f /home/ejneer/Dropbox/Orgzly/finances.ledger bal Assets Liabilities --price-db prices.db")
     ("assets + liabilities" "ledger [[ledger-mode-flags]] -f /home/ejneer/Dropbox/Orgzly/finances.ledger bal Assets Liabilities")
     ("bal" "%(binary) -f %(ledger-file) bal")
     ("reg" "%(binary) -f %(ledger-file) reg")
     ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
     ("account" "%(binary) -f %(ledger-file) reg %(account)")))
 '(package-selected-packages '(org-noter-pdftools org-noter)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
