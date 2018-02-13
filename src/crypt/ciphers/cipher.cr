require "../utils.cr"

module Crypt
  module Ciphers
    abstract class Cipher
      abstract def encrypt(char : Char, *args, **options) : Char
      abstract def decrypt(char : Char, *args, **options) : Char    
    end  
  end
end