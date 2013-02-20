require 'gsl'
#because autoload has not relative_path option
$LOAD_PATH << File.dirname(__FILE__)
module Distribution
	class BaseDistribution
		include GSL
	end
	autoload :Version,  'distibution/version'
	autoload :Normal,   'distribution/normal'
	autoload :Binomial, 'distribution/binomial'

end