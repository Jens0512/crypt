module Crypt
  
  # Crypt extends the String class a bit to simplifiy operations
  # 
  # 
  class ::String

    # Same as `String#<<(alpha : Alphabet)` but returns an alphabet with only unique chars
    # 
    # 
    # ```
    # "HELLLLLLLO" + Alphabet.new "FIIIIIISH" # => Crypt::Alphabet:"HELOFISH"
    # ```
    def + (alpha : Alphabet)
      alphabet(itself.chars.uniq.join << alpha.uniq)
    end

    # Returns an alphabet with the unique chars of the initial string minus the unique chars of `alpha
    # 
    # 
    # ```
    # "HELLO" - Alphabet.new "FISH"     # => Crypt::Alphabet:"ELOFISH"
    # "FISHY_BOB" - Alphabet.new "FISH" # => Crypt::Alphabet:"Y_BOFISH"
    # ```
    def - (alpha : Alphabet)
      alphabet (alphabet(itself.chars.uniq - alpha.uniq.to_s.chars).to_s << alpha.uniq)
    end

    # Returns alphabet with the initial string appended to alpha
    # 
    # 
    # ```
    # "DEF" >> Alphabet.new "ABC" # => Crypt::Alphabet:"ABCDEF"
    # ```
    def >> (alpha : Alphabet)
      alphabet alpha.to_s + itself
    end
    
    # Returns an alphabet where the chars are the initial string, with the chars of `alpha` appended
    #
    #
    # ```
    # "ABC" << Alphabet.new Ciphers.rot3.encrypt("ABC") # => Crypt::Alphabet:"ABCDEF"
    # "HELLO" << Alphabet.new "FISH"                    # => Crypt::Alphabet:"HELLOFISH"
    # ```
    def << (alpha : Alphabet)
      alphabet itself + alpha.to_s
    end

    # Checks wether string is equal to `alpha#to_s`
    def == (alpha : Alphabet)
      itself == alpha.to_s
    end
  end
end
