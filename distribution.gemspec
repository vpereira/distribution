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

  if RUBY_PLATFORM =~ /java/
    gem.platform = 'java'
    #gem.files << 'lib/common_maths/commons-math3-3.2.jar'
  else
    gem.add_dependency('gsl')
  end
  gem.add_dependency('rake')
  gem.add_dependency('gnuplot')
end
