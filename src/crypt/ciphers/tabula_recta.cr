require "colorize"

module Crypt::Ciphers  
  class TabulaRecta < Cipher
    getter? key
    getter alphabet

    def initialize (@alphabet : Alphabet = Alphabet.default, @key : String? = nil); end

    def encrypt(char : Char, key_char : Char, *args) : Char 
      raise "Key must consist of characters in the alphabet!" unless @alphabet.contains?(key_char)
      
      shifted = @alphabet.shift(@alphabet[char.upcase].index - 1)
      @alphabet[shifted[shifted[key_char.upcase].index].index].to_c
    end

    def decrypt(char : Char, key_char : Char, *args) : Char 
      encrypt(char, key_char)
    end

    def encrypt(string, key = @key, *args)
      substitute string, key, true, *args
    end

    def decrypt(string, key = @key, *args)
      substitute string, key, false, *args
    end

    private def substitute(string, key, direction, *args)
      result = [] of Char

      keyit = key.to_s.each_char.cycle
      strit = string.to_s.each_char

      while true
        break if (char = strit.next).is_a? Iterator::Stop

        result << char.upcase && next \
          unless @alphabet.contains?(char.upcase)

        break if (ckey = keyit.next).is_a? Iterator::Stop

        result << (direction ? encrypt(char, ckey) : decrypt(char, ckey))
      end

      Utils.case_to(result.join, string.to_s)
    end

    def print(io : IO = STDOUT); self.print_table(itself, io); end
    
    def self.print_table(alphabet = Alphabet.default, io : IO = STDOUT)
      io.puts "\n  #{alphabet.join(" ").colorize.fore(:white).mode :bold }"
      alphabet.each do |letter|
        line = alphabet.shift(letter.index - 1).join("|").colorize :green

        line.mode :underline unless letter.index == alphabet.size
        left_char = letter.to_c.colorize.fore(:light_green).mode :bold 
        
        io.puts "#{left_char} #{line}"
      end
    end
  end
end