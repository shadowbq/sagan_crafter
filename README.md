# SaganCrafter

Sagan Crafter is designed to help build SAGAN rules from simple backends.

## Code Status

[![Build Status](https://travis-ci.org/shadowbq/threatinator-amqp-rcvr.svg?branch=master)](https://travis-ci.org/shadowbq/threatinator-amqp-rcvr)
[![Gem Version](https://badge.fury.io/rb/threatinator-amqp-rcvr.png)](http://badge.fury.io/rb/threatinator-amqp-rcvr)
[![Tags](https://img.shields.io/github/tag/shadowbq/threatinator-amqp-rcvr.svg)](https://github.com/shadowbq/threatinator-amqp-rcvr/releases)

## Example Sagan Rules created

```
alert tcp $HOME_NET any <> any any (msg:"[PASSIVEDNS] vxvault url_reputation - adobedownloadupdate.com"; content:"adobedownloadupdate.com"; sid:1475620452; normalize:tightstack; program:tightstack; rev:1; metadata:time 1477926621, xxhash 9304759977013689372;)
alert tcp $HOME_NET any <> any any (msg:"[PASSIVEDNS] vxvault url_reputation - ahrenhei.without-transfer.ru"; content:"ahrenhei.without-transfer.ru"; sid:1155553526; normalize:tightstack; program:tightstack; rev:1; metadata:time 1477926621, xxhash 7909456445805000225;)
alert tcp $HOME_NET any <> any any (msg:"[PASSIVEDNS] vxvault url_reputation - atvracing.ru"; content:"atvracing.ru"; sid:1115626887; normalize:tightstack; program:tightstack; rev:1; metadata:time 1477926621, xxhash 7986141927809670135;)
alert tcp $HOME_NET any <> any any (msg:"[PASSIVEDNS] vxvault url_reputation - benchmarkemailsite.com"; content:"benchmarkemailsite.com"; sid:1035073116; normalize:tightstack; program:tightstack; rev:1; metadata:time 1477926621, xxhash 4156062036502574446;)
alert tcp $HOME_NET any <> any any (msg:"[PASSIVEDNS] vxvault url_reputation - benveaskim.com"; content:"benveaskim.com"; sid:1218006184; normalize:tightstack; program:tightstack; rev:1; metadata:time 1477926621, xxhash 801405033058849559;)
```

## Simple Backends:

SQLITE3 - 

```sql
CREATE TABLE fqdns ( id INTEGER PRIMARY KEY, feed_provider varchar(255), feed_name varchar(255), import_time timestamp default (strftime('%s', 'now')), name varchar(255), CONSTRAINT name_unique UNIQUE (import_time, name) )
```

* Threatinator - https://github.com/shadowbq/threatinator
* Threatinator AMQP Client - https://github.com/shadowbq/threatinator-amqp-rcvr

## Note: 

* Sagan - https://github.com/beave/sagan

## Installation

Install it as:

    $ gem install sagan_crafter

## Usage

```    
$ sagan_crafter --help
Usage: sagan-crafter

    -c, --cxtracker                  Create CXTracker rules
    -p, --passivedns                 Create Passivedns rules

Backend

    -s, --sqlite=                    Sqlite3 backend file location
                                       Default: /tmp/threat.db
Options::
    -v, --verbose                    Run verbosely
    -h, --help                       Display this screen

```
## XXHash

XXhash is used to create a reference number from the content matcher. The 64 bit hash is attached as a reference if there is a collision in the sid generation. SID numbers use a weak algorithm that can easily lead to collisions. xxhash used to strictly identify the content of the SAGAN rules.

SIDs are calculated using: 

```ruby
XXhash.xxh32(ioc) % 1000000000 + 1000000000,
```

Reference: https://github.com/Cyan4973/xxHash

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shadowbq/sagan_crafter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
