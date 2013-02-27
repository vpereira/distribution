module Distribution
	class Sample
		include GSL

		attr_accessor :cases

		def initialize(opts = {})
			@type = opts[:type] || :discrete # :discrete | :continuous 
			@distribution = opts[:distribution] # [:normal,:binomial,:poisson,:t]
			@cases = @type == :discrete ? GSL::Vector.alloc(opts[:cases].round.to_a) : opts[:cases]
		end

		def mean
			@cases.mean.round(3)
		end

		def sigma
			@cases.sd(mean).round(3)
		end

		def median
			@cases.median.round(3)
		end

		def n
			@cases.length.to_f
		end
	end
end