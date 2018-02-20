require "../src/crypt"
require "colorize"

# Running this file (with `make sample deranged`)

def pause
  puts
  gets
end

CIPHERTEXT = <<-EOS
PCQ VMJYPD LBYK LYSO KBXBJXWXV BXV ZCJPO EYPD
KBXBJYUXJ LBJOO KCPK. CP LBO LBCMKXPV XPV IYJKL PYDBL,
QBOP KBO BXV OPVOV LBO LXRO CI SX'XJMI KBO JCKO XPV
EYKKOV LBO DJCMPV ZOICJO BYS, KXUYPD: 'DJOXL EYPD, ICJ X
LBCMKXPV XPV CPO PYDBLK Y BXNO ZOOP JOACMPLYPD LC UCM
LBO IXZROK CI FXKL XDOK XPV LBO RODOPVK CI XPAYOPL EYPDK.
SXU Y SXEO KC ZCRV XK LC AJXNO X IXNCMJ CI UCMJ SXGOKLU?'

OFYRCDMO, LXROK IJCS LBO LBCMKXPV CPO PYDBLK
EOS

KEY = "A void by georges perec"

cipher = Ciphers.deranged KEY
cipher.beta.shift! -2

puts
puts  "This sample will show you how to use deranged alphabets"
print "Press enter to continue"

pause
puts "Ciphertext taken from, #{"'The code book'".colorize(:yellow)}, Simon Singh, page 20:"

puts "CIPHERTEXT = <<-EOS"
CIPHERTEXT.each_line do |line|
  puts "  #{line.colorize.mode(:bold).fore(:dark_gray)}"
end
puts "EOS"

pause
puts %<The text is encrypted with a substitutioncipher where a key: \
#{('"' + KEY + '"').colorize.mode(:bold).fore(:blue)} is used.>

pause

DERANGED = LATIN ** KEY

puts  %<The key is then reduced to #{('"' + KEY.chars.uniq.reject(&.whitespace?).map(&.upcase).join + '"').colorize(:blue).mode(:bold)}>
puts  %<And put into a deranged alphabet like this: #{('"' + DERANGED.to_s + '"').colorize.mode(:bold).fore(:blue)}>
pause
puts %<With crypt, such a key reduction can be done like this:\n\n>
puts %[  LATIN ** "#{KEY}" # => "#{DERANGED}"].colorize.mode(:bold)
pause
puts %<The `**` operator is used for mashing and deranging a key into an alphabet>
pause
puts %<Then it is shifted right by 2: #{('"' + DERANGED.shift(-2).to_s + '"').colorize.mode(:bold).fore(:blue)}>
puts %<Probably because the creator of the cipher didn't want the first character of the substitutionalphabet to be an 'A'>
pause
puts %<All in all, the deranged alphabet can be created like this in crypt:\n\n>

puts %[  (LATIN ** "#{KEY}").shift! -2 # => "#{(LATIN ** KEY).shift -2}\n].colorize.mode(:bold)
pause

puts %<Now that we have the cipher used to encrypt the text, we can create the cipher object:>
puts
puts %<  cipher = Ciphers.deranged("#{KEY}"))>.colorize.mode :bold
puts %<  cipher.beta.shift! -2>.colorize.mode :bold
puts
puts %<Or like this:>
puts
puts %<  cipher = Ciphers.substitution(LATIN, (LATIN ** KEY).shift -2)>.colorize.mode :bold
puts
pause
puts %<And finally decrypt the ciphertext:>
puts %<  puts cipher.decrypt CIPHERTEXT>.colorize.mode :bold
puts
Ciphers.substitution(LATIN, (LATIN ** KEY).shift -2)\
  .decrypt(CIPHERTEXT).each_line do |line|
    puts "  #{line}".colorize.mode(:bold).fore :blue
  end
#cipher.decrypt CIPHERTEXT