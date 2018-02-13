require "../spec_helper"
require "benchmark"

describe Alphabet do
  describe "#[]" do
    it "takes a char as argument to get letter for a char" do
      ROMAN['X'].should eq 'X'
      ROMAN['G'].should eq 'G'

      ROMAN['A'].index.should eq 1
      ROMAN['F'].index.should eq 6
    end

    it "takes an int as argument to get the char of an index" do
      ROMAN[1].should eq 'A'
      ROMAN[-1].should eq 'Z'
    end

    it "the first index is 1, 0 should raise an `IndexError`" do
      expect_raises(IndexError) { ROMAN[0] }
    end

    it "raises an IndexError when a char, that is not in the alphabet is passed" do
      expect_raises(IndexError) { ROMAN['⍉'] }
      expect_raises(IndexError) { ROMAN['∑'] }
    end

    it "raises an IndexError when passed integer is an off bounds index" do
      expect_raises(IndexError) { ROMAN[1874123] }
      expect_raises(IndexError) { ROMAN[4214] }
    end
  end

  describe "#[]?" do
    it "returns nil when `#[]` would have thrown an error" do
      ROMAN[0]?.should eq nil
      ROMAN['√']?.should eq nil
      ROMAN['A']?.should eq 'A'
    end
  end

  describe "#to_s" do
    ROMAN.to_s.should eq "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  end

  describe "#size" do
    it "returns the total amount of chars in the alphabet" do
      ROMAN.size.should eq 26

      Alphabet.new("rbwod").size.should eq 5
      Alphabet.new("jkhg").size.should eq 4
    end
  end

  describe "new" do
    it "takes a string or array of chars as an argument" do
      norwegian = Alphabet.new(ROMAN.to_s + "ÆØÅ")
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
      ROMAN.join(", ").should eq ROMAN.to_s.split("").join(", ")
      Alphabet.new("123").join("-").should eq "1-2-3"
    end
  end

  describe "#contains?" do
    it "returns wether an alphabet contains `char`" do
      ROMAN.contains?('A').should be_true
      ROMAN.contains?('B').should be_true
      ROMAN.contains?('C').should be_true

      ROMAN.contains?('1').should be_false
      ROMAN.contains?('ƒ').should be_false
      ROMAN.contains?('∞').should be_false
    end
  end  

  describe "#shift" do
    it "returns a new alphabet with all chars shifted by the amount specified" do
      # " - " is used here to show where the shift displaces the alphabet
      ROMAN.shift(-3).to_s.should eq "XYZ - ABCDEFGHIJKLMNOPQRSTUVW".gsub(/ - /, "")
      ROMAN.shift(3).to_s.should eq "DEFGHIJKLMNOPQRSTUVWXYZ - ABC".gsub(/ - /, "")
    end

    it "uses the modulo of a shift if it is higher than the length of the initial , eg. with \
    the roman alphabet, a shift of 54 would return the same as a shift of 2" do
      ROMAN.shift(54).should eq ROMAN.shift(2)

      # This test, tests wether the time difference between the two shifts are too large.
      # If it fails, something is wrong with the way the shift is performed,
      # as the two produces the same result, they should be produced the same way,
      # hence they should take the same time to produce
      Benchmark.realtime do
        ROMAN.shift(28981489384247150) # 28981489384247150 % 26 = 10
      end.milliseconds.should be_close(Benchmark.realtime do
        ROMAN.shift(10) # 10 % 26 = 10
      end.milliseconds, 0.1)
    end
  end

  describe "#shift!" do
    it "transforms self into shifted version" do
      roman = Alphabet.new(ROMAN.to_s)
      roman.should eq ROMAN

      roman.shift! 3
      roman.should eq ROMAN.shift 3

      roman.shift! -3
      roman.should eq ROMAN
    end

    it "does not transform alphabet that is initialized as final" do
      roman_copy_before_shift = Alphabet.new(ROMAN.to_s)

      expect_raises(Exception) { ROMAN.shift! 10 } # ROMAN is declared as final in `crypt.cr`
      ROMAN.should eq roman_copy_before_shift
    end
  end
end
