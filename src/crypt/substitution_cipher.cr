class SubstitutionCipher
	def initialize (@alpha : Alphabet, @beta : Alphabet)
		unless (@alpha.length == @beta.length)
			raise "The two alphabets in a substitution cipher must be the same length" 
		end
	end

	def encrypt(string)
		encrypted = ""
		string.to_s.upcase.chars.each do |c|
			unless @alpha.contains? c
				encrypted += c
				next
			end
			encrypted += @beta[@alpha[c].index].char
		end
		encrypted
	end

	def decrypt(string)
		decrypted = ""
		string.to_s.upcase.chars.each do |c|
			unless @alpha.contains? c
				decrypted += c
				next
			end
			decrypted += @alpha[@beta[c].index].char
		end
		decrypted
	end
end
