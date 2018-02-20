require "../utils.cr"

module Crypt
  module Ciphers
    abstract class Cipher
      abstract def encrypt(io : IO, string : String, *args, **opts)
      abstract def decrypt(io : IO, string : String, *args, **opts)

      def encrypt(string, *args, **opts) : String
        String.build do |io|
          encrypt(io, string.to_s, *args, **opts)
        end
      end

      def decrypt(string, *args, **opts) : String
        String.build do |io|
          decrypt(io, string.to_s, *args, **opts)
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