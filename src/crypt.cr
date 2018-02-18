require "./crypt/*"

module Crypt
  include Ciphers

  include Constants  

  extend self

  def alphabet(letters, **opts)
    Alphabet.new letters, **opts
  end

  # :nodoc:
  def bug_found! (line = __LINE__, file = __FILE__)
    STDERR.puts <<-BUG_FOUND
    You have found a bug in the Crypt library!
    Caught in #{file}:#{line}
    Please open an issue in #{GITHUB_LINK}
    with reproducable problem and minimal code.
    BUG_FOUND

    exit 1
  end
end