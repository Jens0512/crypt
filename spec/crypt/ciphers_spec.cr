require "../../spec_helper"

describe Ciphers do
  describe "substitution" do
    it "returns a `SubstitutionCipher`" do
      cipher = Ciphers.substitution("123", "456")
      cipher.should be_a SubstitutionCipher

      cipher.encrypt("2013").should eq "5046"
    end
  end

  describe "caesar" do
    it "returns a roman caesar-shifted `SubstitutionCipher`" do
      rot3 = Ciphers.caesar 3
      rot3.should be_a SubstitutionCipher

      rot3.alpha.should eq ROMAN
      rot3.beta.should  eq ROMAN.shift 3

      rot3.encrypt("1234").should eq "1234"
    end
  end

  describe "atbash" do
    it "returns the atbash cipher" do
      atbash = Ciphers.atbash
      atbash.should be_a SubstitutionCipher

      atbash.encrypt("Hello").should eq "Svool"
      atbash.encrypt("Fish").should  eq "Urhs"
    end
  end

  describe "deranged" do
    it "returns a simlpe mixed alphabet" do
      zebras = Ciphers.deranged("ZEBRAS")
      zebras.beta.should eq "ZEBRASCDFGHIJKLMNOPQTUVWXY"
      
      zebras.encrypt("Flee at once. we are discovered!").should eq "Siaa zq lkba. va zoa rfpbluaoar!"

      Ciphers.deranged("BOBBY").beta.should eq "BOYACDEFGHIJKLMNPQRSTUVWXZ"
    end
  end

  describe "dvorak" do
    it "returns the qwerty substitution of the plaintext" do
      dvorak = Ciphers.dvorak

      dvorak.case_sensitive?.should       be_true
      dvorak.alpha.case_sensitive?.should be_true
      dvorak.beta.case_sensitive?.should  be_true

      dvorak.encrypt("Hello").should eq "D.nnr"
      dvorak.decrypt("Ucodf ucod ucod.o a ucod").should eq "Fishy fish fishes a fish"
    end
  end
end
