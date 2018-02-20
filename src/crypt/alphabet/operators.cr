module Crypt
  class Alphabet
    def [](index : Char | Int, upcase? : Bool? = nil)
      if index.is_a? Char
        if letter = get_letter(index)
          letter
        else; raise IndexError.new ("Alphabet does not contain '#{index}'"); end
      else
        raise IndexError.new("The first index is of 1, so index 0 cannot be used") if index == 0
        letter = @letters[(index >= 1) ? (index - 1) : index]
        if upcase?.is_a? Nil
          return letter
        else
          return (upcase? ? letter.downcase : letter.upcase)
        end
      end      
    end

    def []?(index : Char | Int, upcase? : Bool? = nil)
      begin
        return itself[index]
      rescue e : IndexError
        return nil
      end
    end

    # Returns the letter of char in the alphabet. 
    # If alphabet does not contain the letter: `nil` is returned
    private def get_letter(char : Char)
      each do |letter|
        return letter.case_to(char) if (letter == char)
      end; nil
    end

    def ==(other : Alphabet)
      itself.to_s == other.to_s
    end

    def ==(string : String)
      itself.to_s == string
    end

    def <<(other : Alphabet)
     alphabet(itself.to_s + other.to_s)
    end

    def <<(string : String)
     alphabet(itself.to_s + string)
    end

    def >>(other : Alphabet)
     alphabet(other.to_s + itself.to_s)
    end

    def >>(string : String)
     alphabet(string + itself.to_s)
    end

    def ** (other : Alphabet)          
      itself ** other.to_s
    end

    def ** (string : String)
      string = string.gsub /\ /, ""
      string + (itself - string)
    end

    def - (other : Alphabet)
      itself - other.to_s
    end

    def - (string : String)
      result = itself.to_s
      string.chars.each do |char|
        result = result.sub (case_sensitive? ? char : char.upcase), "" 
      end
      alphabet result
    end
  end
end