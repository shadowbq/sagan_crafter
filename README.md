# SaganCrafter

Sagan Crafter is designed to help build SAGAN rules from simple backends.

```
alert tcp $HOME_NET any <> any any (msg:"[PASSIVEDNS] vxvault url_reputation - tscl.com.bd"; content:"tscl.com.bd"; normalize:tightstack; sid:1635309608; program:tightstack; rev:2;)
alert tcp $HOME_NET any <> any any (msg:"[PASSIVEDNS] vxvault url_reputation - uclmfocus.com"; content:"uclmfocus.com"; normalize:tightstack; sid:1042387290; program:tightstack; rev:2;)
alert tcp $HOME_NET any <> any any (msg:"[PASSIVEDNS] vxvault url_reputation - upstreams.info"; content:"upstreams.info"; normalize:tightstack; sid:1757176352; program:tightstack; rev:1;)
alert tcp $HOME_NET any <> any any (msg:"[PASSIVEDNS] vxvault url_reputation - vibaavaacademy.com"; content:"vibaavaacademy.com"; normalize:tightstack; sid:1270011767; program:tightstack; rev:1;)
alert tcp $HOME_NET any <> any any (msg:"[PASSIVEDNS] vxvault url_reputation - www.cpteducation.it"; content:"www.cpteducation.it"; normalize:tightstack; sid:1499466929; program:tightstack; rev:1;)
alert tcp $HOME_NET any <> any any (msg:"[PASSIVEDNS] vxvault url_reputation - www.itidea.it"; content:"www.itidea.it"; normalize:tightstack; sid:1352812295; program:tightstack; rev:2;)
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shadowbq/sagan_crafter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
