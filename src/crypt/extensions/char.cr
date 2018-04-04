module Crypt
  struct ::Char
    # Returns a dup of this char, cased to `char`
    def case_of(char : Char)
      char.uppercase? ? itself.upcase : itself.downcase
    end
  end
end
