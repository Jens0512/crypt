require "../src/crypt"
require "readline"

module RotX
  include Readline
  include Crypt

  extend self

  def start
    puts "\nThis sample encrypts text with the caesar cipher, with the provided key."
    loop do         
      got = readline("Key; Shift from 1 to 25: ")

      if got && got.to_i?
        shift = got.to_i
        
        plaintext = readline("Text to encrypt        : ")
        cipher    = Ciphers.caesar shift
        puts %(Encrypted text : "#{cipher.encrypt plaintext}"\n\n)
      else
        puts %("#{got.to_s}" is not a valid shift.)
      end
    end
  end
end

RotX.start