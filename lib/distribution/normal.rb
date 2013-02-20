module Distribution
	#implemented just pdf
	class Normal < BaseDistribution
		attr_reader :m, :o
		def initialize(x = [0], mean = 0.0, stddev = 1.0)
			@m = mean
			@o = stddev
			@x = x
		end
		def variance
			@o ** 2
		end
		def pdf
			@x.collect { |x| Ran::gaussian_pdf(x, @o) }
		end


	end
end
