module Crypt
  struct Alphabet
    # Shifts an alphabet `shift` to the left
    # 
    # ```
    # alphabet("1234567").shift 3 # => #<Crypt::Alphabet:"4567123">
    # alphabet("Hello", case_sensitive?: true).shift 1 # => #<Crypt::Alphabet:"elloH">
    # ```
    def shift(shift : Int)
      Alphabet.shift(itself, shift)
    end

    # :nodoc:
    def self.shift(shift : Int)
      self.shift(default, shift)
    end

    # Transforms the cipher to become the 
    # shifted of `shift` version of itself, see `#shift`
    def shift!(shift : Int)
      must_be_not_final "Alphabet#shift!"
      @letters = shift(shift).letters
      itself
    end

    def finalize!; @final = true; end

    # Returns an alphabet with every character of this reversed
    # 
    # ```
    # alphabet("1234").reverse # => #<Crypt::Alphabet:"4321">
    # ```
    def reverse
      alphabet @letters.reverse.join("")
    end

    def reverse!
      must_be_not_final "Alphabet#reverse!"

      @letter.reverse!
      correct_indexes
      itself
    end

    private def must_be_not_final(method_called : String? = nil)
      if @final
        raise "The method #{method_called || "you called"} cannot be used on alphabets initialized with `final?: true`"
      end
    end

    private def correct_indexes
      i = 1
      @letters.map do |letter|
        letter.index = i
        i += 1
      end
    end
  end
end