(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ledger-reports
   '(("commodity filter" "cat *.ledger | ledger -f - reg -l \"commodity=~/SNDL/\"")
     ("Net Worth" "cat *.ledger | ledger -f - bal ^Assets ^Liabilities -V --price-db prices.db")
     ("taxes" "cat *.ledger | ledger -f - bal taxes \"employer paid\" --period \"last year\" -l 'any(account =~ /Income:SB&D:Regular/)' ")
     ("assets + liabilities ($ basis)" "cat *.ledger | ledger -f - bal Assets Liabilities -V --price-db prices.db")
     ("assets + liabilities" "cat *.ledger | ledger -f - bal Assets Liabilities")
     ("Balance, cash and credit cards" "cat *.ledger | ledger -f - bal \"credit cards\" \\(assets:cash and not escrow\\) \\(investment and not health\\) --cleared --value --price-db prices.db")
     ("reg" "cat *.ledger | ledger -f - reg")
     ("bal credit cards" "ledger -f %(ledger-file) bal \"credit cards\" --cleared")
     ("bal" "cat *.ledger | ledger -f - bal")
     ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
     ("account" "%(binary) -f %(ledger-file) reg %(account)")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
