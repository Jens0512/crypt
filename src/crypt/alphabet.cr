require "./letter"

module Crypt
  struct Alphabet
    class_property default = ROMAN

    include Indexable(Int32 | Char)

    def [](index : Char)      
      if letter = get_letter(index)
        letter
      else
        raise IndexError.new ("Alphabet does not contain #{index}")
      end
    end

    def [](index : Int)
      if index == 0
        raise IndexError.new("The first index is of 1, so 0 cannot be used") 
      end      

      @letters[(index >= 1 ) ? (index - 1) : index]
    end

    def []?(index : Char | Int)
      begin
        return itself[index]
      rescue e : IndexError
        return nil
      end
    end

    def == (other : Alphabet)
      (join "") == other.to_s
    end

    private def get_letter(char : Char)
      each do |letter|
        return letter if (letter == char)
      end
      nil
    end

    def each(&block)
      @letters.each do |letter|
        yield letter
      end
    end

    def length
      @letters.size
    end

    def to_s(io : IO)
      io << join ""
    end

    def join(delimeter : String)
      @letters.join delimeter
    end  

    def contains?(char : Char)
      @letters.each { |letter| return true if letter == char}

      false
    end

    @letters : Array(AlphabetLetter)

    protected def letters; @letters; end

    def initialize(letters : String, upcase? : Bool = true, final? : Bool = false)
      initialize letters.chars, upcase?, final?
    end

    def initialize(letters : Array(Char), upcase? : Bool = true, final? : Bool = false)
      @final = final?
      @letters = Array(AlphabetLetter).new
      i = 1
      letters.each do |letter|
        @letters << AlphabetLetter.new((upcase? ? letter.upcase : letter), i)
        i += 1
      end      
    end

    def shift(shift : Int)
      Alphabet.shift(self, shift)
    end

    def self.shift(shift : Int)
      self.shift(default, shift)
    end

    def self.shift(initial : Alphabet, shift : Int) : Alphabet
      return initial if shift == 0
  		shift %= initial.length
      shifted = ""  		    

      initial.each do |letter|        
        ordinal = letter.index + shift

        if (ordinal.abs > initial.length)
          ordinal %= initial.length 
        end

        shifted += initial[ordinal].to_c
      end

      Alphabet.new shifted
    end

    def shift!(*args)      
      @letters = shift(*args).letters unless @final
      itself
    end

    private struct AlphabetLetter < SymbolBase
      property! index

      def initialize(char : Char, @index : Int32)
        super(char)
      end
    end
  end
end