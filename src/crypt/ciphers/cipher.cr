require "../utils.cr"

module Crypt
  module Ciphers
    abstract class Cipher
      abstract def encrypt(io : IO, string : String, *args, **opts)
      abstract def decrypt(io : IO, string : String, *args, **opts)

      def encrypt(alpha : Alphabet, *args, **opts) : String
        String.build do |io|
          encrypt(io, alpha.to_s, *args, **opts)
        end
      end

      def decrypt(alpha : Alphabet, *args, **opts) : String
        String.build do |io|
          decrypt(io, alpha.to_s, *args, **opts)
        end
      end

      def encrypt(string : String, *args, **opts) : String
        String.build do |io|
          encrypt(io, string, *args, **opts)
        end
      end

      def decrypt(string : String, *args, **opts) : String
        String.build do |io|
          decrypt(io, string, *args, **opts)
        end
      end

      def decrypt(char : Char, *args, **opts)
        decrypt(char.to_s, *args, **opts)
      end

      def encrypt(char : Char, *args, **opts)
        encrypt(char.to_s, *args, **opts)
      end
    end
  end
end