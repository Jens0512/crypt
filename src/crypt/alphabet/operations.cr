module Crypt
  struct Alphabet        
    # Yields each `Crypt::AlphabetLetter` in the alphabet
    def each(&block)
      @letters.each do |letter|
        yield letter
      end
    end

    # Returns the amount of letters in the alphabet
    def size
      @letters.size
    end

    def to_s(io : IO)
      io << join
    end

    def inspect(io : IO)
      io << %(#<Crypt::Alphabet:"#{to_s}">)
    end

    def uniq(case_sensitive? : Bool = @case_sensitive, **opts)
      alphabet join.chars.uniq, **opts, case_sensitive?: case_sensitive?
    end

    def join(delimeter : String = "")
      @letters.join delimeter
    end

    def contains?(char : Char)
      @letters.each { |letter| return true if letter == char }

      false
    end    
  end
end