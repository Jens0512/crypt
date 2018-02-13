require "../../spec_helper"

describe TabulaRecta do   
  describe "#encrypt" do
    cipher = TabulaRecta.new 

    cipher.encrypt("My spoon, is too big", "pickle").should eq "Dk kvxqc, ak rxq oaw"
    cipher.encrypt("d", "m").should eq "j"    
  end

  describe "#decrypt" do
    cipher = TabulaRecta.new

    cipher.decrypt("Dk kvxqc, ak rxq oaw", "pickle").should eq "My spoon, is too big"
  end
end