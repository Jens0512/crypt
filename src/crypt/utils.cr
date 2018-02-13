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
      key = key.to_s

      result = [] of Char

      itr = key.each_char.cycle

      at = 0
      while length > at
        nxt = itr.next
        result << nxt if nxt.is_a? Char
        at += 1
      end

      result.join ""
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
    
    # TODO: This
    #
    # `
    #def alphabetic_sort(string : String, alpha : Alphabet)
    #
    #end
  end
end