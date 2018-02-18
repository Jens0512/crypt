[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://jens0512.github.io/crypt/)

# crypt

This is a amateur WIP, made for fun, and is not of good quality.

Crypt is a crystal-library for encrypting and decrypting cipers.

Most of what is here works like it should, apart for some problems with casing in alphabet chars, this is easily avoided by using only uppercased chars, but im working on fixing the bufg, the bug causes case-sensitive ciphers like the dvorak-substitution-cipher to not work properly.

I have no expertise in ciphers, so **any** constructive feedback is very much welcome, even just a simple explanation of expexted behaviour.

Currently the only avaible ciphers are simple substitution-ciphers, and the tabula recta.
## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  crypt:
    github: Jens0512/crypt
```

## Usage

```crystal
require "crypt"
include Crypt
```

Simple caesar ciphers
```crystal
rot3 = Ciphers.caesar 3
encrypted = rot3.encrypt "This, is, weak!" # => "Wklv, lv, zhdn!"
rot3.decrypt encrypted # => "This, is, weak!"
rot3.encrypt "This, is, weak!", cut_unknown?: true # => "Wklv lv zhdn"
```

Simple substitution-ciphers
```crystal
cipher = Ciphers.substitution("1234", "4321")
cipher.encrypt "12345" # => "43215"
cipher.decrypt "400" # => "100"
``` 

## Contributing
Help wanted! See: #1

1. Fork it ( https://github.com/[your-github-name]/crypt/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Jens0512](https://github.com/Jens0512) Jens - creator, maintainer
