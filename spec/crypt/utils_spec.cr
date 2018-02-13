describe Utils do
  describe "key_to_length" do    
    it "returns the range from 0 to length if the key is longer than passed length" do
      Utils.key_to_length("fish", 2).should eq "fi"
    end

    it "returns the key repeated until length is reached" do
      Utils.key_to_length("fish", 12).should eq ("fish" * 3)
    end

    it "returns a range of the key when you won't get a whole" do
      key = "myawesomekey"
      
      Utils.key_to_length("123456789", 14).should eq "12345678912345"
      Utils.key_to_length("fish", 6).should       eq "fishfi"
      Utils.key_to_length(key, 15).should         eq key + "mya"
    end
  end
end