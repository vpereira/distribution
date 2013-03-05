require 'gsl'
require 'gnuplot'

#because autoload has not relative_path option
$LOAD_PATH << File.dirname(__FILE__)
module Distribution
	class BaseDistribution
		attr_reader :samples,:hist
		include GSL

		def initialize(opts = {})
			@samples = Vector.alloc(100)
		end

		def X(using=:mean)
			Vector.alloc(@samples.collect { |x| x.send(:mean) })
		end

		def hist
			@hist = GSL::Histogram.alloc(self.X.to_a.size)
			@hist.set_ranges_uniform(self.X.to_a.min,self.X.to_a.max)
			@hist.fill(self.X.round.to_a)
			@hist
		end

		#TODO
		#move it to a Mixing module
		def z_score
			raw_scores.collect { |r| (r - mean) / sigma }
		end

		private
		def random_handle
			GSL::Rng.alloc(GSL::Rng::MT19937,rand(31337))
		end
	end
	autoload :Version,  'distibution/version'
	autoload :Normal,   'distribution/normal'
	autoload :Binomial, 'distribution/binomial'
	autoload :Poisson,  'distribution/poisson'
	autoload :Sample,   'distribution/sample'
end