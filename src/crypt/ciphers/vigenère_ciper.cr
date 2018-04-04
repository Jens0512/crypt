module Crypt::Ciphers  
  class VigenereCipher < TabulaRecta
    private property atbash : Cipher

    def initialize (alphabet : Alphabet = Alphabet.default, key : String? = nil)
      @atbash = Ciphers.atbash alphabet

      super # !
    end

    def encrypt(io : IO, string, key = @key, *args)
      super(io, atbash.encrypt(string), key, *args)
    end

    def decrypt(io : IO, string, key = @key, *args)
      super(io, atbash.decrypt(string), key, *args)
    end

    # I must see this to see how to use the tabula to create a vigenère
    # http://crypto.interactive-maths.com/other-examples.html

  end
end

puts VigenereCipher.new.encrypt("Hello")