require "../spec_helper"

describe SymbolBase do
  # Use `Letter` because `SymbolBase` is abstract, and Letter is a simple implementation
  describe "#==" do
    it "returns wether a char is equal itself" do
      # `...should eq x` expands to `... == x`

      Letter.new('x').should      eq 'x'
      Letter.new('2').should      eq '2'

      Letter.new('F').should_not  eq 'f'
      Letter.new('j').should_not  eq 'f'
    end

    it "returns wether another SymbolBase is equal to itself" do
      Letter.new('X').should     eq Letter.new('X')
      Letter.new('V').should     eq Letter.new('V')

      Letter.new('c').should_not eq Letter.new('C')
      Letter.new('p').should_not eq Letter.new('h')
    end
  end

  describe "#to_s" do
    it "returns the itself as a string" do
      Letter.new('x').to_s.should     eq "x"
      Letter.new('C').to_s.should     eq "C"

      Letter.new('l').to_s.should_not eq "L"
    end
  end

  describe "#to_c" do
    it "returns the char of a symbol" do
      Letter.new('x').to_c.should      eq 'x'
      Letter.new('2').to_c.should      eq '2'

      Letter.new('F').to_c.should_not  eq 'f'
      Letter.new('j').to_c.should_not  eq 'f'
    end
  end

  describe "#downcase" do
    it "delegates to Char#downcase" do
      Letter.new('A').downcase.should eq 'a'
    end
  end  
end