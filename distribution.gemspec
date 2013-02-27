# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'distribution/version'

Gem::Specification.new do |gem|
  gem.name          = "distribution"
  gem.version       = Distribution::VERSION
  gem.authors       = ["Victor Pereira"]
  gem.email         = ["vpereira@web.de"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency('minitest')
  gem.add_development_dependency('pry')
  gem.add_dependency('gsl')
  #gem.add_dependency('numbers_in_words')
  gem.add_dependency('gnuplot')
end
