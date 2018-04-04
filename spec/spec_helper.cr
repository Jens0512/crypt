require "spec"
require "../src/crypt"

include Crypt

def letter(char : Char, case_sensitive? : Bool = true)
  SymbolBase::SingleLetter.new char, case_sensitive?
end

{% for shift in (1...26) %}
  ROT{{shift}} = Ciphers.caesar {{shift}}
{% end %}
