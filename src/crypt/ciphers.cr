require "./ciphers/*"

module Crypt
  # Module containing all ciphers
  module Ciphers
    extend self

    # See `Ciphers::SubstitutionCipher.new`
    def substitution(*args, **opts)
      SubstitutionCipher.new(*args, **opts)
    end

    # Exactly the same as `Ciphers#caesar`, but without default shift
    def rot(shift : Int, alpha = Alphabet.default, **opts)
      caesar(shift, alpha, **opts)
    end

    # Same as `substitution(alphabet, alphabet.shift(shift))`    
    def caesar(shift : Int = 3, alpha : Alphabet = Alphabet.default, **opts)
      substitution(alpha, alpha.shift(shift), **opts)
    end

    # Creates a deranged alphabet where `key` is inserted to the alphabet
    #
    # ```
    # Ciphers.deranged("BOBBY").beta # => "BOYACDEFGHIJKLMNPQRSTUVWXZ"
    # ```
    # This is the operation:
    # ```
    # substitution(alpha, key.chars.uniq.join + (alpha - key))
    # ```
    def deranged(key : String, alpha : Alphabet = Alphabet.default, *, \
        include_whitespace? : Bool = false)

      key = (include_whitespace? ? key : key.gsub(/\ /, ""))
      substitution(alpha, alpha ** key)
    end

    # Creates a substitution-cipher where characters 
    # are substituted with characters of the same 
    # alphabet but reversed
    # 
    # `Ciphers.atbash.encrypt "ABC" # => "ZYX`
    def atbash(alpha : Alphabet = Alphabet.default)
      substitution(alpha, alpha.reverse)
    end

    # Encrypts text by taking the QWERTY keyboard indices of the chars and replacing them by the Dvorak equavilent index
    #     
    # ```
    # dvorak.encrypt "Fish" # => "Ucod"
    # ```
    # 
    # The cipher is a substitution-cipher, see `Constants.DVORAK_CIPHER
    def dvorak
      DVORAK_CIPHER
    end

    SUBSTITUTIONFLAGS = {:upcase, :keep_case}
  end
end
