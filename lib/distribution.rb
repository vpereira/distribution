#because autoload has not relative_path option
$LOAD_PATH << File.dirname(__FILE__)
module Distribution

	#TODO
	#one for jruby and one for mri
	autoload :BaseDistribution, 'distribution/base_distribution'

	autoload :Version,    'distibution/version'
        #for now we have a native ruby histogram implementation
	autoload :Histogram,  'distribution/jruby/histogram'

	if RUBY_PLATFORM =~ /java/
	  autoload :Binomial,   'distribution/jruby/binomial'
	  autoload :Exponential,'distribution/jruby/exponential'
	  autoload :Poisson,    'distribution/jruby/poisson'
	else
	  autoload :Normal,     'distribution/mri/normal'
	  autoload :Binomial,   'distribution/mri/binomial'
	  autoload :Poisson,    'distribution/mri/poisson'
	  autoload :Exponential,'distribution/mri/exponential'
	  autoload :T,          'distribution/mri/t'
	  autoload :Sample,     'distribution/mri/sample'
        end
end
