module Distribution

	class PopulationUnkownException < Exception;end

	class Sample
		include GSL

		attr_accessor :cases
		attr_reader :distribution

		def initialize(opts = {})
			@type = opts[:type] || :discrete # :discrete | :continuous 
			@distribution = opts[:distribution] # [:normal,:binomial,:poisson,:t]
			@cases = @type == :discrete ? GSL::Vector.alloc(opts[:cases].round.to_a) : opts[:cases]
			@population_n = opts[:population] || :unknown
			@precision = opts[:precision] || 3
		end

		def t
			raise PopulationUnkownException,"You didn't provide the population size" if @population_n == :unknown
			(@population_n - n) / sampling_error
		end

		def sampling_error
			sigma / sqrt(n)
		end

		def mean
			@cases.mean.round(@precision)
		end

		def sigma
			@cases.sd(mean).round(@precision)
		end

		def median
			@cases.median.round(@precision)
		end

		def n
			@cases.length.to_f
		end
	end
end