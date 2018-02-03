latin = Alphabet.latin
if false  
  cipher = SubstitutionCipher.new(latin, latin.shift(-3_i16))
  puts <<-EOS
Latin:                 #{latin}
Latin shifted 3 left:  #{latin.shift(-3_i16)}
Latin shifted 3 right: #{latin.shift(3_i16)}

"Hello" encrypted with the 3 left shifted cipher is: "#{cipher.encrypt("Hello").capitalize}"

Another example:
\t#{"THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG".downcase}
\t==
\t#{(cipher.encrypt("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG")).downcase}
Here its decrypted again:
\t#{(cipher.decrypt cipher.encrypt("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG")).downcase}
\n
EOS
  r : Int16
  r = rand(20_i16)
  cipher2 = SubstitutionCipher.new(latin, latin.shift(r))
  puts <<-EOS
with ceasar shift of #{r} left
"Hello" becomes "#{(cipher2.encrypt "Hello").capitalize}"
EOS
end

puts SubstitutionCipher.new(latin, latin.shift(13)).encrypt(
  <<-EOS
  LBH AREQF UNIR QBAR JRYY GB TRG GUVF SNE,SBYYBJVAT ZL RAPBQRQ ZRFFNTRF.NF N ERJNEQ FB SNE,V TVIR LBH GUVF ZRFFNTR:


  LZW NWJVAUL OADD TW VWUAVWV DSLW AF LZW KWUGFV EGFLZ.

  HFR JUNG LBH XABJ.GB XABJ GUR CNFG VF GB XABJ GUR SHGHER.
  EOS
)
