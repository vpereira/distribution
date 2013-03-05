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

		def hist(data_to_hist=[])
			@hist = Histogram.new data:data_to_hist
			@hist.gen
		end

		def z_score
			raw_scores.collect { |r| (r - mean) / sigma }
		end

		private
		def random_handle
			GSL::Rng.alloc(GSL::Rng::MT19937,rand(31337))
		end
	end
	autoload :Version,   'distibution/version'
	autoload :Normal,    'distribution/normal'
	autoload :Binomial,  'distribution/binomial'
	autoload :Poisson,   'distribution/poisson'
	autoload :Sample,    'distribution/sample'
	autoload :Histogram, 'distribution/histogram'
end