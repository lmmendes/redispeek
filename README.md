# redispeek

A small redis database peeker (or explorer) with a web interface! yay!
:D

*Please note that this is a developer preview, don't use it in production :D*

## Running

```bash
# You need to have redis running so start it
redis-server

# since this gem has not been released clone the repo to your hard drive
git clone git@github.com:lmmendes/redispeek.git

# enter the redispeek folder and run "bundle" command
bundle

# start redispeek via bin
ruby bin/redispeek

# to kill the redispeek server pass the "-K" argument to the redispeek bin
ruby bin/redispeek -K
```

## Bug reports and other issues

* https://github.com/lmmendes/redispeek/issues

## Help and Docs

* https://github.com/lmmendes/redispeek/wiki

## Contributing

* Fork the project.
  * Make your feature addition or bug fix.
    * Add tests for it. This is important so I don't break it in a
future version unintentionally.
* Send me a pull request. Bonus points for topic branches.

## License

Redispeek is free software distributed under the terms of the MIT license
reproduced [here](http://opensource.org/licenses/mit-license.html).

