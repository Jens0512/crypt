require "spec"
require "../src/crypt"

include Crypt

def letter(letter : Char, case_sensitive? : Bool = true)
  Alphabet::Letter.new letter, case_sensitive?
end

{% for shift in (1...26) %}
  ROT{{shift}} = Ciphers.caesar {{shift}}
{% end %}