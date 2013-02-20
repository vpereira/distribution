module Distribution
	#just PMF is implemented
	#you can pass one k (number of successes) or an array
	class Binomial < BaseDistribution
		attr_reader :n,:p,:q,:k
		def initialize(n = 0, k = 0, p = 0.5)
			@n = n
			@p = p
			@q = 1 - @p
			@k = k
		end

		def pmf
			if @k.is_a? Array 
				@k.collect do |k|
					binomial_coefficient_from_array(k) * (pow_int(@p, k) * pow_int(@q,(@n-k)))	
				end
			else
				binomial_coefficient * (pow_int(@p, @k) * pow_int(@q,(@n-@k)))
			end
		end
		
		def binomial_coefficient
			Sf::fact(@n) / (Sf::fact(@k) * Sf::fact(@n - @k))
		end

		def binomial_coefficient_from_array(k)
			Sf::fact(@n) / (Sf::fact(k) * Sf::fact(@n - k))
		end

		def mean
			@n * @p
		end

	end
end
