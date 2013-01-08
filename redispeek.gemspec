# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "redispeek/version"

Gem::Specification.new do |s|
  s.name        = "redispeek"
  s.version     = Redispeek::VERSION
  s.authors     = ["Luis Mendes"]
  s.email       = ["lmmendes@gmail.com"]
  s.homepage    = "http:/lmmendes.eu"
  s.summary     = %q{Redis peeker}
  s.description = %q{A web interface for peeking into redis databases}

  s.rubyforge_project = "redispeek"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "sinatra", ">= 0.9.2"
  s.add_runtime_dependency "redis", "~> 3.0.1"
  s.add_runtime_dependency "vegas", "~> 0.1.11"
  s.add_runtime_dependency "json"

end
