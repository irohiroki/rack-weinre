# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rack/weinre/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Hiroki Yoshioka"]
  gem.email         = ["irohiroki@gmail.com"]
  gem.description   = %q{rack-weinre inserts a script tag that loads a weinre target js into html files.}
  gem.summary       = %q{A rack middleware for Weinre remote debugger.}
  gem.homepage      = "https://github.com/irohiroki/rack-weinre"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rack-weinre"
  gem.require_paths = ["lib"]
  gem.version       = Rack::Weinre::VERSION
  gem.add_development_dependency "capybara", "~> 1.1.2"
  gem.add_development_dependency "rspec", "~> 2.9.0"
end
