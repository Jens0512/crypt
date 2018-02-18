module Crypt
  module Constants
    extend self

    # The latin alphabet, the same as the english
    LATIN = Alphabet.new "ABCDEFGHIJKLMNOPQRSTUVWXYZ", final?: true

    # The chars for the standard western keyboard layout *Qwerty*
    QWERTY = Alphabet.new "`1234567890-=qwertyuiop[]\\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:\"ZXCVBNM<>?", final?: true, case_sensitive?: true
    
    # The chars for an alternative keyboard layout *Dvorak*
    DVORAK = Alphabet.new "`1234567890[]',.pyfgcrl/=\\aoeuidhtns-;qjkxbmwvz~!@#$%^&*(){}\"<>PYFGCRL?+|AOEUIDHTNS_:QJKXBMWVZ", final?: true, case_sensitive?: true
    
    DVORAK_CIPHER = Ciphers.substitution QWERTY, DVORAK

    # For debug comparison:
    # # QWERTY => `1234567890-=qwertyuiop[]\\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:\"ZXCVBNM<>?
    # # DVORAK => `1234567890[]',.pyfgcrl/=\\aoeuidhtns-;qjkxbmwvz~!@#$%^&*(){}\"<>PYFGCRL?+|AOEUIDHTNS_:QJKXBMWVZ
  end
end