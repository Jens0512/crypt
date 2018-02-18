module Crypt
  # NOTE: This class is not currently very useful, in fact it is quite a lot less useful than a normal `Char`
  # 
  # TODO: add ways for a symbol to be anything, like a word or for example either a or b at the same time
  #
  # :nodoc:
  abstract struct SymbolBase
    getter? case_sensitive
    
    protected property char

    protected def initialize(@char : Char, case_sensitive? : Bool) 
      @case_sensitive = case_sensitive?
    end

    def ==(other : SymbolBase)
      if (itself.case_sensitive? || other.case_sensitive?)
        return @char == other.to_c
      else
        return @char.upcase == other.to_c.upcase
      end
    end

    def ==(other : Char)
      itself.case_sensitive? ? (@char == other) : (@char.upcase == other.upcase)
    end

    def to_s(io : IO)
      io << to_c
    end

    def inspect(io : IO)
      to_s io
    end

    def to_c
      itself.case_sensitive? ? @char : @char.upcase
    end

    # :nodoc:
    def case_to(char : Char)
      new_char = itself.dup
      new_char.char = (char.uppercase? ? @char.upcase : @char.downcase)
      new_char
    end    
    
    def upcase
      new_char = itself.dup
      new_char.char = new_char.char.upcase
      new_char
    end

    def downcase
      new_char = itself.dup
      new_char.char = new_char.char.downcase
      new_char
    end

    delegate uppercase?, to: @char
  end

  class Alphabet
    # :nodoc:
    struct Letter < SymbolBase; end

    private struct AlphabetLetter < SymbolBase
      property! index      

      def initialize(char : Char, @index : Int32, parent : Alphabet)
        super(char, parent.case_sensitive?)
      end
    end
  end
end
