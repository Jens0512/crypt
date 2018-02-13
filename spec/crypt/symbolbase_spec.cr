require "../spec_helper"


describe SymbolBase do  
  # Use `Letter` because `SymbolBase` is abstract, and Letter is a simple implementation
  describe "#==" do
    it "returns wether a char is equal itself" do
      # `...should eq x` expands to `... == x`

      letter('x').should eq 'x'
      letter('2').should eq '2'

      letter('F').should_not eq 'f'
      letter('j').should_not eq 'f'
    end

    it "returns wether another SymbolBase is equal to itself" do
      letter('X').should eq letter('X')
      letter('V').should eq letter('V')

      letter('c').should_not eq letter('C')
      letter('p').should_not eq letter('h')
    end
  end

  describe "#to_s" do
    it "returns the itself as a string" do
      letter('x').to_s.should eq "x"
      letter('C').to_s.should eq "C"

      letter('l').to_s.should_not eq "L"
    end
  end

  describe "#to_c" do
    it "returns the char of a symbol" do
      letter('x').to_c.should eq 'x'
      letter('2').to_c.should eq '2'

      letter('F').to_c.should_not eq 'f'
      letter('j').to_c.should_not eq 'f'
    end
  end

  describe "#downcase" do
    it "delegates to Char#downcase" do
      letter('A').downcase.should eq 'a'
    end
  end
end
