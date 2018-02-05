# crypt

This is a amateur WIP, made for fun, and is not of good quality, but most of what is here works like it should.
Currently the only avaible ciphers are simple substitution-ciphers
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
cipher = Ciphers.substitution(Alphabet.new("1234"), Alphabet.new("4321"))
cipher.encrypt "12345" # => "43215"
cipher.decrypt "400" # => "100"
``` 

## Contributing

1. Fork it ( https://github.com/[your-github-name]/crypt/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Jens0512](https://github.com/Jens0512) Jens - creator, maintainer
