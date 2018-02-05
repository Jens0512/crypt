require "./crypt/*"

module Crypt 
  ROMAN = Alphabet.new "ABCDEFGHIJKLMNOPQRSTUVWXYZ", final?: true

  {% for i in (1...26) %} 
    ROT{{i}} = Ciphers.caesar {{i}} 
  {% end %}  
end