describe Alphabet do
	latin = Alphabet.new "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		
	describe "#[]" do 
		latin['a'].index.should eq 1
	end

	describe "#to_s" do
		latin.to_s.should eq "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	end

	describe "#shift" do 
		(latin.shift (-3_i16)).to_s.should eq "XYZABCDEFGHIJKLMNOPQRSTUVW"
	end
end
