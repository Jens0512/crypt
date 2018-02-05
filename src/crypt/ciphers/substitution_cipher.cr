module Crypt
  class SubstitutionCipher
    property alpha, beta
    def initialize(alpha : String, beta : String, enforce_length? : Bool = true)
      new(Alphabet.new(alpha), Alphabet.new(beta), enforce_length?)  
    end
    
    def initialize(@alpha : Alphabet, @beta : Alphabet, enforce_length? : Bool = true)
      if (@alpha.length != @beta.length) && enforce_length?
        raise "The two alphabets in a substitution cipher must be the same length" 
      end
    end

    def encrypt(string : String, keep_case? : Bool = true, cut_unknown? : Bool = false, cut_whitespace? : Bool = false)
      shift string, true, keep_case?, cut_unknown?, cut_whitespace?
    end

    def decrypt(string : String, keep_case? : Bool = true, cut_unknown? : Bool = false, cut_whitespace? : Bool = false)
      shift string, false, keep_case?, cut_unknown?, cut_whitespace?
    end

    private def shift(string, direction, keep_case?, cut_unknown?, cut_whitespace?)      
      shifted = [] of Char
      string.to_s.chars.each do |c|
        upcased? = (c.upcase == c) if keep_case?
        c = c.upcase
        unless (@alpha.contains?(c) || @alpha.contains? c.downcase)
          shifted << c if (c.whitespace?  && !cut_whitespace?) || (!c.whitespace? && !cut_unknown?)          
          next
        end
        char = direction ? 
          ((@beta [@alpha[c].index]?) || c)
           : 
          ((@alpha[@beta [c].index]?) || c)
        char = char.to_c unless char.is_a? Char
        if keep_case?
          shifted << (upcased? ? char.upcase : char.downcase) 
        else
          shifted << char.upcase
        end
      end
      shifted.join("")
    end
  end
end
