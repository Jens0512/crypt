describe SubstitutionCipher do  
  describe "#new" do
    #`Ciphers.substitution` is a helper to SubstitutionCipher.new
    cipher = Ciphers.substitution(ROMAN, ROMAN.shift -3)
    cipher.alpha.should eq ROMAN
    cipher.beta.should  eq ROMAN.shift -3
  end

  describe "#encrypt" do
    it "encrypts a string" do
      # Shortcut to `SubstitutionCipher.new(ROMAN, ROMAN.shift 10)`
      cipher = Ciphers.caesar 11
      
      cipher.encrypt("Hello").should eq "Spwwz"
      cipher.encrypt("lol").should   eq "wzw"

      ROT3.encrypt("A").should eq "D"
      ROT3.encrypt("B").should eq "E"
      ROT3.encrypt("C").should eq "F"
    end

    it "works with any alphabet" do
      cipher = Ciphers.substitution(Alphabet.new("123456789"), Alphabet.new("987654321"))
      
      cipher.encrypt("123").should eq "987"
      cipher.encrypt("987").should eq "123"
    end

    it "takes a second argument, specifying wether to keep case, or to upcase everything" do
      # The classic
      cipher = Ciphers.caesar 3 # == ROT3 # => true
      cipher.encrypt("Veni vidi vici", keep_case?: false).should eq "YHQL YLGL YLFL"
      cipher.encrypt("Veni vidi vici", keep_case?: true).should  eq "Yhql ylgl ylfl"
    end

    it "takes a third argument, specifying wether to cut unknown chars or not" do    
      ROT3.encrypt("Hello Bob, nr. 123", cut_unknown?: true).rstrip.should eq "Khoor Ere qu"
      ROT3.encrypt("Hello Bob, nr. 123", cut_unknown?: false).should       eq "Khoor Ere, qu. 123"
    end

    it "takes a fourth argument, specifying wether to keep whitespace or not" do
       ROT3.encrypt("Veni vidi vici", cut_whitespace?: true).should  eq "Yhqlylglylfl"
       ROT3.encrypt("Veni vidi vici", cut_whitespace?: false).should eq "Yhql ylgl ylfl"
    end
  end

  describe "#decrypt" do
    it "encrypts a string" do
      # Shortcut to `SubstitutionCipher.new(ROMAN, ROMAN.shift 10)`
      cipher = Ciphers.caesar 11
      
      cipher.decrypt("Spwwz").should eq "Hello"
      cipher.decrypt("wzw").should   eq "lol"

      ROT3.decrypt("D").should eq "A"
      ROT3.decrypt("E").should eq "B"
      ROT3.decrypt("F").should eq "C"
    end

    it "works with any alphabet" do
      cipher = Ciphers.substitution(Alphabet.new("123456789"), Alphabet.new("987654321"))
      
      cipher.decrypt("987").should eq "123"
      cipher.decrypt("123").should eq "987"
    end

    it "takes a second argument, specifying wether to keep case, or to upcase everything" do
      # The classic
      cipher = Ciphers.caesar 3 # == ROT3 # => true
      cipher.decrypt("YHQL YLGL YLFL", keep_case?: false).should eq "VENI VIDI VICI"
      cipher.decrypt("Yhql ylgl ylfl", keep_case?: true).should  eq "Veni vidi vici"
    end

    it "takes a third argument, specifying wether to cut unknown chars or not" do    
      ROT3.decrypt("Khoor Ere, qu. 123", cut_unknown?: true).rstrip.should eq "Hello Bob nr"
      ROT3.decrypt("Khoor Ere, qu. 123", cut_unknown?: false).should       eq "Hello Bob, nr. 123"
    end

    it "takes a fourth argument, specifying wether to keep whitespace or not" do
       ROT3.decrypt("Yhqlylglylfl", cut_whitespace?: true).should  eq "Venividivici"
       ROT3.decrypt("Yhql ylgl ylfl", cut_whitespace?: false).should eq "Veni vidi vici"
    end
  end
end