module Crypt
  abstract struct SymbolBase    
    protected def initialize(@char : Char); end

    def == (other : SymbolBase)
      @char == other.to_c
    end

    def == (other : Char)
      @char == other
    end

    def to_s(io : IO)
      io << @char
    end

    def to_c
      @char
    end
    
    delegate downcase, downcase!, to: @char
  end

  struct Letter < SymbolBase; end
end