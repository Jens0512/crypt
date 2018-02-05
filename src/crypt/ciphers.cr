module Crypt
  module Ciphers
    def self.substitution(*args)
      SubstitutionCipher.new(*args)
    end

    def self.caesar(shift : Int)
      return SubstitutionCipher.new(ROMAN, ROMAN.shift(shift))
    end
  end
end