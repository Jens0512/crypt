require "../spec_helper"
require "benchmark"

describe Alphabet do
  describe "#[]" do
    it "takes a char as argument to get letter for a char" do
      LATIN['X'].should eq 'X'
      LATIN['G'].should eq 'G'

      LATIN['A'].index.should eq 1
      LATIN['F'].index.should eq 6
    end

    it "takes an int as argument to get the char of an index" do
      LATIN[1].should eq 'A'
      LATIN[-1].should eq 'Z'
    end

    it "the first index is 1, 0 should raise an `IndexError`" do
      expect_raises(IndexError) { LATIN[0] }
    end

    it "raises an IndexError when a char, that is not in the alphabet is passed" do
      expect_raises(IndexError) { LATIN['⍉'] }
      expect_raises(IndexError) { LATIN['∑'] }
    end

    it "raises an IndexError when passed integer is an off bounds index" do
      expect_raises(IndexError) { LATIN[1874123] }
      expect_raises(IndexError) { LATIN[4214] }
    end
  end

  describe "#[]?" do
    it "returns nil when `#[]` would have thrown an error" do
      LATIN[0]?.should eq nil
      LATIN['√']?.should eq nil
      LATIN['A']?.should eq 'A'
    end
  end

  describe "#to_s" do
    LATIN.to_s.should eq "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  end

  describe "#size" do
    it "returns the total amount of chars in the alphabet" do
      LATIN.size.should eq 26

      Alphabet.new("rbwod").size.should eq 5
      Alphabet.new("jkhg").size.should eq 4
    end
  end

  describe "new" do
    it "takes a string or array of chars as an argument" do
      norwegian = Alphabet.new(LATIN.to_s + "ÆØÅ")
      norwegian[1].should eq 'A'
      norwegian[-1].should eq 'Å'
    end

    it "doesn't need to make sense" do
      apl_alphabet = Alphabet.new "⍺⊥∩⌊∊_∇∆⍳∘’⎕|⊤○*?⍴⌈~↓∪⍵⊃↑⊂"
      apl_alphabet['∇'].should eq '∇'
      apl_alphabet[apl_alphabet['∇'].index + 1].should eq '∆'
    end
  end

  describe "#join" do
    it "returns a string with `delimeter` between each char in the alphabet" do
      LATIN.join(", ").should eq LATIN.to_s.split("").join(", ")
      Alphabet.new("123").join("-").should eq "1-2-3"
    end
  end

  describe "#contains?" do
    it "returns wether an alphabet contains `char`" do
      LATIN.contains?('A').should be_true
      LATIN.contains?('B').should be_true
      LATIN.contains?('C').should be_true

      LATIN.contains?('1').should be_false
      LATIN.contains?('ƒ').should be_false
      LATIN.contains?('∞').should be_false
    end
  end  

  describe "#shift" do
    it "returns a new alphabet with all chars shifted by the amount specified" do
      # " - " is used here to show where the shift displaces the alphabet
      LATIN.shift(-3).to_s.should eq "XYZ - ABCDEFGHIJKLMNOPQRSTUVW".gsub(/ - /, "")
      LATIN.shift(3).to_s.should eq "DEFGHIJKLMNOPQRSTUVWXYZ - ABC".gsub(/ - /, "")
    end

    it "uses the modulo of a shift if it is higher than the length of the initial , eg. with \
    the latin alphabet, a shift of 54 would return the same as a shift of 2" do
      LATIN.shift(54).should eq LATIN.shift(2)

      # This test, tests wether the time difference between the two shifts are too large.
      # If it fails, something is wrong with the way the shift is performed,
      # as the two produces the same result, they should be produced the same way,
      # hence they should take the same time to produce
      Benchmark.realtime do
        LATIN.shift(28981489384247150) # 28981489384247150 % 26 = 10
      end.milliseconds.should be_close(Benchmark.realtime do
        LATIN.shift(10) # 10 % 26 = 10
      end.milliseconds, 0.1)
    end
  end

  describe "#shift!" do
    it "transforms self into shifted version" do
      latin = Alphabet.new(LATIN.to_s)
      latin.should eq LATIN

      latin.shift! 3
      latin.should eq LATIN.shift 3

      latin.shift! -3
      latin.should eq LATIN
    end

    it "does not transform alphabet that is initialized as final" do
      latin_copy_before_shift = Alphabet.new(LATIN.to_s)

      expect_raises(Exception) { LATIN.shift! 10 } # LATIN is declared as final in `crypt.cr`
      LATIN.should eq latin_copy_before_shift
    end
  end
end
