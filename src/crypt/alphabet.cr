class Alphabet
  include Indexable(Int16 | Char)

  def [](index : Char)
    index = index.upcase
    letter = get_letter(index)
    if letter
      return letter
    else
      raise IndexError.new ("Alphabet does not contain #{index}")
    end
  end

  def at(index)
    if (index > self.length)
      index %= self.length
    end
    @letters[index - 1]
  end

  private def get_letter(char : Char)
    each do |letter|
      return letter if (letter.char == char)
    end
    nil
  end

  def unsafe_at(index)
    @letters[index]?
  end

  def each(&block)
    @letters.each do |letter|
      yield letter
    end
  end

  def length
    @letters.size
  end

  @@LATIN = Alphabet.new "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  
	def self.latin : Alphabet
    @@LATIN
  end

  def to_s(io : IO)
    io << join ""
  end

  def join(delimeter : String)
    @letters.join delimeter
  end

  def has(char : Char)
    each do |letter|
      return true if letter.char == char
    end
    false
  end

  def contains?(char : Char)
    @letters.each do |letter| 
      return true if letter.char == char
    end

    false
  end

  @letters : Array(Letter)

  def initialize(letters : String)
    initialize letters.chars
  end

  def initialize(letters : Array(Char))
    @letters = Array(Letter).new
    i = 1_i16
    letters.each do |letter|
      unless has(letter)
        @letters << Letter.new(letter.upcase, i)
        i += 1
      else
        abort "An alphabet must not contain multiple equal characters"
      end
    end
  end

  def shift(shift : Int)
    Alphabet.shift(self, shift)
  end

  def self.shift(shift : Int)
    self.shift(self.latin, shift)
  end

  def self.shift(initial : Alphabet, shift : Int) : Alphabet
    return initial if shift == 0
		shift %= initial.length
    shifted = ""
		#shift += 1 if shift > 0
    initial.each do |letter|
      unless letter
        abort "Nil encountered!"
      end
      shifted += initial[(letter.index + shift)].char
    end
    Alphabet.new shifted
  end

  class Letter
    property! char, index

    def initialize(@char : Char, @index : Int16)
    end

    def to_s(io : IO)
      io << @char
    end
  end
end
