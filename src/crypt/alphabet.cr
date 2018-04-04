require "./alphabet/*"

module Crypt
  # An alphabet does not neccesarily have to be the 
  # latin "abc...xyz" alphabet, but can be any length of chars.
  # Used in the ciphers here for just about everything
  struct Alphabet
    include Enumerable(Letter)
    
    # Used in the `Ciphers`-module
    # Change to whatever you'd like
    class_property default : Alphabet = LATIN

    include Indexable(Int32 | Char)

    @letters : Array(Letter)

    protected def letters; @letters; end
        
    getter? case_sensitive = false

    # Creates an alphabet with the characters of letters
    # 
    # 
    # ```
    # Alphabet.new "hello fish" # => #<Crypt::Alphabet:"HELLO FISH">
    # Alphabet.new "Hello Fish", case_sensitive?: true # => #<Crypt::Alphabet:"hello fish">
    # ```
    def initialize(letters : String, *, case_sensitive? : Bool = false, final? : Bool = false)
      initialize letters.chars, case_sensitive?: case_sensitive?, final?: final?
    end

    # Same as `Alphabet.initialize(letters : String)
    def initialize(letters : Array(Char), *, case_sensitive? : Bool = false, final? : Bool = false)
      @case_sensitive = case_sensitive?
      @final = final?

      @letters = [] of Letter

      i = 1
      letters.each do |letter|
        @letters << Letter.new((case_sensitive? ? letter : letter.upcase), i, itself)
        i += 1
      end
    end

    # Passes alpha.to_s and **opts to `Alphabet.new(letters: String, *)`
    def initialize(alpha : Alphabet, **opts)
      initialize alpha.to_s, **opts
    end

    # Returns an alphabet that is a shift by `shift` of `initial`
    # 
    # `opts` are passed to the initialization of the shifted alphabet,
    # the new alphabet has by default the same case sensitivity as the initial alphabet
    def self.shift(initial : Alphabet, shift : Int, case_sensitive? : Bool = initial.case_sensitive?, **opts) : Alphabet
      return initial if shift == 0
      shift %= initial.size
      shifted = [] of Char
 
      initial.each do |letter|
        ordinal = letter.index + shift
 
        if (ordinal.abs > initial.size)
          ordinal %= initial.size 
        end
 
        shifted << initial[ordinal].to_c
      end
 
      new shifted.join, **opts, case_sensitive?: case_sensitive?
    end
  end
end
