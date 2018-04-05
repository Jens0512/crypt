module Crypt::Ciphers  
  class VigenereCipher < TabulaRecta
    private property atbash : Cipher

    def initialize (alphabet : Alphabet = Alphabet.default, key : String? = nil)
      super Ciphers.atbash(alphabet), key
    end

    def encrypt(io : IO, string, key = @key, *args)
      super
    end

    def decrypt(io : IO, string, key = @key, *args)
      super
    end

    # I must see this to see how to use the tabula to create a vigenère
    # http://crypto.interactive-maths.com/other-examples.html

  end
end