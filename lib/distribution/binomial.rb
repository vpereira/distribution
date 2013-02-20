module Distribution
	#just PMF is implemented
	#you can pass one k (number of successes) or an array
	class Binomial < BaseDistribution
		attr_reader :n,:p,:q,:k
		def initialize(n = 0, k = [0], p = 0.5)
			@n = n
			@p = p
			@q = 1 - @p
			@k = k
		end

		def pmf
			@k.collect { |k| binomial_coefficient_from_array(k) * (pow_int(@p, k) * pow_int(@q,(@n-k)))	} 
		end

		def binomial_coefficient_from_array(k)
			Sf::fact(@n) / (Sf::fact(k) * Sf::fact(@n - k))
		end

		def cdf(x)
			if @k.include?(x)
				@k.sort[0..@k.sort.index(x)].collect { |k| binomial_coefficient_from_array(k) * (pow_int(@p, k) * pow_int(@q,(@n-k)))}.inject(:+) 
			else
				0
			end
		end

		def mean
			@n * @p
		end

	end
end
