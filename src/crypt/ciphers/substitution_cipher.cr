module Crypt::Ciphers  
  class SubstitutionCipher < Cipher
    getter alpha, beta
  
    getter? cut_whitespace  = false
    getter? cut_unknown     = false

    protected setter cut_whitespace, cut_unknown

    def initialize(alpha, beta, cut_whitespace? : Bool = false, cut_unknown? : Bool = false, **opts)
      initialize Alphabet.new(alpha.to_s, **opts), Alphabet.new(beta.to_s, **opts), cut_whitespace?, cut_unknown?
    end

    def initialize(@alpha : Alphabet, @beta : Alphabet, cut_whitespace? : Bool = false, cut_unknown? : Bool = false)
      itself.cut_whitespace = cut_whitespace?
      itself.cut_unknown    = cut_unknown?

      if (@alpha.size != @beta.size)
        raise "The two alphabets in a substitution cipher must be the same length"
      end
    end

    def encrypt(string, *args)
      substitute string, true,  *args
    end

    def decrypt(string, *args)
      substitute string, false, *args
    end

    def known?(char : Char?, direction : Bool)
      return false unless char
      return (direction ? (@alpha.contains? char) : (@beta.contains? char))
    end

    private def subst(char : Char, direction : Bool = true)
      return (direction ? @beta[@alpha[char].index] : @alpha[@beta[char].index]).to_c
    end

    private def subst_part(prev_char, current_char, next_char, direction)
      return case
      when prev_char && !prev_char.whitespace?
        subst(current_char, direction)

      when next_char.is_a?(Char) && !next_char.whitespace?
        subst(current_char, direction)

      when current_char
        subst(current_char, direction)

      when prev_char && next_char.is_a?(Char) && \
          current_char.whitespace? && !known?(prev_char, direction) && !known?(next_char, direction)
        subst(current_char, direction)

      else
        nil
      end
    end

    private def substitute(string, direction : Bool, *args)
      keep_case? = !(args.includes? :no_keep_case) 
      upcase? = args.includes? :upcase 
 
      if !keep_case? && upcase? 
        raise "You must not provide both the `:no_keep_case` and the `:upcase` flag, as that is paradoxal and would not work" 
      end

      itr     = string.to_s.each_char
      itr_nxt = string.to_s.each_char.skip 1

      result  = [] of Char

      until (char = itr.next).is_a? Iterator::Stop
        uppercase? = char.uppercase?
        next_char  = itr_nxt.next

        case 
        when known?(char, direction)
          substituted = subst_part(result.last?, char, next_char, direction)
        when cut_whitespace? && char.whitespace?
          next
        when cut_unknown? && !char.whitespace?
          next            
        when cut_whitespace? && char.whitespace? && next_char.is_a?(Char) && next_char.whitespace?
          next        
        else
          substituted = char
        end

        if substituted
          case 
          when upcase?
            result << substituted.upcase
          when keep_case?
            result << (uppercase? ? substituted.upcase : substituted.downcase)            
          else
            result << substituted
          end
        end
      end

      result.join
    end

    def transform!(cut_whitespace? : Bool = @cut_whitespace, \
                   cut_unknown?    : Bool = @cut_unknown)

      @cut_whitespace  = cut_whitespace?
      @cut_unknown     = cut_unknown?

      itself
    end

    def transform(cut_whitespace? : Bool = @cut_whitespace, \
                  cut_unknown?    : Bool = @cut_unknown)
      return itself.dup if (cut_whitespace? == @cut_whitespace) && (cut_unknown? == @cut_unknown) 
       
      # Create a duplicate of this cipher 
      transformed                 = itself.dup 

      # And apply the new config to it
      transformed.cut_whitespace  = cut_whitespace? 
      transformed.cut_unknown     = cut_unknown? 
       
      return transformed 
    end

    {% for p in {:alpha, :beta} %}
      def {{p.id}}=(alpha : Alphabet)
        if (@{{p.id}}.size != alpha.size)
          raise "The new {{p.id}} must be the same length as the previous"
        end

        @{{p.id}} = alpha
      end
    {% end %}

    def reverse
      reversed = new @beta, @alpha
      reversed.transform(
        cut_whitespace?: @cut_whitespace,
        cut_unknown?:    @cut_unknown
      )
    end

    def to_s(io : IO)
      io << "⦕⦕#{@alpha}ψ#{@beta}⦖⦖"
    end

    # Creates a human readable string representation of the cipher
    # 
    # 
    # ```
    # puts Ciphers.substitution("Yeah", "True").to_hr_s    
    # ```
    # 
    # outputs: 
    # ```text
    # SubstitutionCipher:
    #   Alpha: YEAH
    #   Beta : TRUE
    # ```
    def to_hr_s
      to_hrs(IO::Memory.new).to_s
    end

    # 
    def to_hr_s(io : IO)
      io << "SubstitutionCipher:\n"
      io << "\tAlpha: #{@alpha }\n"
      io << "\tBeta : #{@beta  }"
    end

    def inspect(io : IO)
      io << "Crypt::SubstitutionCipher(#{@alpha}ψ#{@beta})"
    end

    def case_sensitive?
      @alpha.case_sensitive?||@beta.case_sensitive?
    end
  end  
end
