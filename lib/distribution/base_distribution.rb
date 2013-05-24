require 'gsl'
require 'gnuplot'

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

	def get_samples(s,c,replacement=false,type=:discrete)
		
		replacement_method = if replacement
			:sample
		else
			:choose
		end

		@samples = 1.upto(s).collect do 
			Distribution::Sample.new(cases: random_handle.send(replacement_method,get_cases(s,c),c), 
				type: type, distribution: name_to_distribution) 
		end
		@samples
	end 

	def get_cases(s,c)
		raise NotImplementedError,"you must implement it get_cases"
	end
	
	private
	
	def name_to_distribution
		self.class.to_s.split('::').last.downcase.to_sym
	end

	def random_handle
		GSL::Rng.alloc(GSL::Rng::MT19937,rand(31337))
	end
  end
end
