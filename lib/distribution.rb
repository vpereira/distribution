require 'gsl'
require 'gnuplot'

#because autoload has not relative_path option
$LOAD_PATH << File.dirname(__FILE__)
module Distribution
	class BaseDistribution
		include GSL
		#TODO
		#move it to a Mixing module
		def z_score
			raw_scores.collect { |r| (r - mean) / sigma }
		end
	end
	autoload :Version,  'distibution/version'
	autoload :Normal,   'distribution/normal'
	autoload :Binomial, 'distribution/binomial'
	autoload :Poisson,  'distribution/poisson'
	autoload :Sample,   'distribution/sample'
end