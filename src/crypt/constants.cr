module Crypt
  module Constants
    extend self

    # The latin alphabet, the same as the english
    LATIN = Alphabet.new "ABCDEFGHIJKLMNOPQRSTUVWXYZ", final?: true

    # :nodoc:
    QWERTY_KEYS = "`1234567890-=qwertyuiop[]\\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:\"ZXCVBNM<>?"
    
    # The chars for the standard western keyboard layout *Qwerty*
    QWERTY = Alphabet.new QWERTY_KEYS, final?: true, case_sensitive?: true
    
    # :nodoc:
    DVORAK_KEYS = "`1234567890[]',.pyfgcrl/=\\aoeuidhtns-;qjkxbmwvz~!@#$%^&*(){}\"<>PYFGCRL?+|AOEUIDHTNS_:QJKXBMWVZ"

    # The chars for an alternative keyboard layout *Dvorak*
    DVORAK = Alphabet.new DVORAK_KEYS, final?: true, case_sensitive?: true
    
    DVORAK_CIPHER = Ciphers.substitution QWERTY, DVORAK

    # For debug comparison:
    # # QWERTY => `1234567890-=qwertyuiop[]\\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:\"ZXCVBNM<>?
    # # DVORAK => `1234567890[]',.pyfgcrl/=\\aoeuidhtns-;qjkxbmwvz~!@#$%^&*(){}\"<>PYFGCRL?+|AOEUIDHTNS_:QJKXBMWVZ
  end
end