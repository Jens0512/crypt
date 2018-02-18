describe SubstitutionCipher do
  describe "#new" do
    # `Ciphers.substitution` is a helper to SubstitutionCipher.new
    cipher = Ciphers.substitution(ROMAN, ROMAN.shift -3)
    cipher.alpha.should eq ROMAN
    cipher.beta.should  eq ROMAN.shift -3
  end

  describe "#encrypt" do
    it "encrypts a string" do
      # Shortcut to `SubstitutionCipher.new(ROMAN, ROMAN.shift 11)`
      cipher = Ciphers.caesar 11

      cipher.encrypt("Hello").should eq "Spwwz"
      cipher.encrypt("lol").should   eq "wzw"
    end

    it "encrypts a char" do
      ROT3.encrypt('A').should eq "D"
      ROT3.encrypt('B').should eq "E"
      ROT3.encrypt('C').should eq "F"
    end

    it "tries to handle whitespace and unknown symbols in a logical way" do
       rot3 = Ciphers.caesar 3
       rot3 = rot3.transform cut_unknown?: true
      rot3.decrypt(rot3.encrypt "Th51.12_is12431, iº¬˘¯∑s, _we∘⍺⌈’∆?ak!").should eq "This is weak"
    end

    describe "takes symbol varargs" do
      it "takes an `:upcase` flag, which upcases everything" do      
        # The classic
        cipher = Ciphers.caesar 3 # == ROT3 # => true
        cipher.encrypt("Veni vidi vici", :upcase).should eq "YHQL YLGL YLFL"
        cipher.encrypt("Veni vidi vici").should          eq "Yhql ylgl ylfl"
      end
    end

    it "works with any alphabet" do
      cipher = Ciphers.substitution(Alphabet.new("123456789"), Alphabet.new("987654321"))

      cipher.encrypt("123").should eq "987"
      cipher.encrypt("987").should eq "123"
    end    
  end

  describe "#transform" do
    it "takes an argument specifying whether to cut unknown chars or not" do
      # Encryption
      ROT3.transform(cut_unknown?: true).encrypt("Hello Bob, nr. 123").should  eq "Khoor Ere qu"
      ROT3.transform(cut_unknown?: false).encrypt("Hello Bob, nr. 123").should eq "Khoor Ere, qu. 123"

      # Decryption
      ROT3.transform(cut_unknown?: true).decrypt( "Khoor Ere, qu. 123").should eq "Hello Bob nr"
      ROT3.transform(cut_unknown?: false).decrypt("Khoor Ere, qu. 123").should eq "Hello Bob, nr. 123"
    end

    it "takes an argument specifying whether to keep whitespace or not" do
      # Encryption
      ROT3.transform(cut_whitespace?: true).encrypt("Veni vidi vici").should  eq "Yhqlylglylfl"
      ROT3.transform(cut_whitespace?: false).encrypt("Veni vidi vici").should eq "Yhql ylgl ylfl"

      # Decryption
      ROT3.transform(cut_whitespace?: true).decrypt("Yhqlylglylfl").should    eq "Venividivici"
      ROT3.transform(cut_whitespace?: false).decrypt("Yhql ylgl ylfl").should eq "Veni vidi vici"
    end

    it "takes two args" do
      ROT3.transform(cut_unknown?: true, cut_whitespace?: true).encrypt("Hello Bob, nr. 123", :upcase).should eq "KHOOREREQU"
    end
  end  

  describe "#decrypt" do
    it "encrypts a string" do
      # Shortcut to `SubstitutionCipher.new(ROMAN, ROMAN.shift 10)`
      cipher = Ciphers.caesar 11

      cipher.decrypt("Spwwz").should eq "Hello"
      cipher.decrypt("wzw").should   eq "lol"      
    end

    it "encrypts a char" do
      ROT3.decrypt('D').should eq "A"
      ROT3.decrypt('E').should eq "B"
      ROT3.decrypt('F').should eq "C"
    end

    it "works with any alphabet" do
      cipher = Ciphers.substitution(Alphabet.new("123456789"), Alphabet.new("987654321"))

      cipher.decrypt("987").should eq "123"
      cipher.decrypt("123").should eq "987"

      cipher.decrypt(cipher.beta).should eq cipher.alpha
    end

    it "keeps the case of the plaintext by default" do
      cipher = Ciphers.caesar 3

      cipher.decrypt("YHQL YLGL YLFL").should eq "VENI VIDI VICI"
      cipher.decrypt("Yhql ylgl ylfl").should eq "Veni vidi vici"
    end

    describe "takes synbol varargs" do
      it "takes an `:upcase` symbol, which upcases the result" do
        cipher = Ciphers.caesar 3

        cipher.decrypt("Yhql ylgl ylfl", :upcase).should eq "VENI VIDI VICI"
        cipher.decrypt("Yhql ylgl ylfl").should          eq "Veni vidi vici"
      end
    end
  end
end
