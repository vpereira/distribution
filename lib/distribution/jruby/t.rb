require_relative './distribution'
java_import 'org.apache.commons.math3.distribution.TDistribution'


module Distribution
	class T 
		attr_accessor :nu, :x, :precision
		def initialize(opts = {})
			@nu = opts[:nu] || 0 #degrees of freedom
			@precision = opts[:precision] || 3
			@x =  opts[:x] || [0] 
			@d_handle = TDistribution.new(@nu)
		end

		def pdf
			@x.collect { |x| @d_handle.density(x).round(@precision) }
		end

		def cdf(lower_tail=true)
                  if lower_tail
			@x.collect { |x| @d_handle.cumulativeProbability(x).round(@precision) }
                  else
			@x.collect { |x| (1 - @d_handle.cumulativeProbability(x)).round(@precision) }
                  end
		end
	end
end
