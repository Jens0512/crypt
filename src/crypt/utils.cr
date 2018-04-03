module Crypt
  # Handy utils
  # Notably `#key_to_length` and `#case_to`
  module Utils
    extend self

    # Same as `#key_to_length` where `length` is passed as the size of `string`
    def key_to_length(key, string); key_to_length(key, string.size); end

    # Repeats `key` until it is the size of `length`
    # 
    # ```
    # Utils.key_to_length "fish", 10 # => "fishfishfi"
    # Utils.key_to_length "nota bene", 3 # => "not"
    # ```
    def key_to_length(key, length : Int)  
      itr = key.to_s.each_char.cycle
      result = [] of Char
      length.times do
        nxt = itr.next
        result << nxt if nxt.is_a? Char        
      end

      result.join
    end


    # Turns every char in `string` to the same index case of `delta`
    # 
    # ```
    # Utils.case_to "HELLO", "BoBBy" # => "HeLLo"
    # ```
    def case_to(string : String, delta : String)
      result = [] of Char

      sitr = string.each_char
      ditr = delta.each_char 

      while true
        break if (dc = ditr.next).is_a? Iterator::Stop
        break if (sc = sitr.next).is_a? Iterator::Stop

        result << (dc.uppercase? ? sc.upcase : sc.downcase)
      end

      result.join
    end
    
    def alphabetic_sort(string : String, alpha : Alphabet)
      string.sort_by do |c1, c2|
        return false unless alpha.includes?(c1) && alpha.includes?(c2)
        return alpha[c1].index > alpha[c2].index
      end
    end
  end
end