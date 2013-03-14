module Distribution
	class T < BaseDistribution
		attr_accessor :nu, :x, :precision
		def initialize(opts = {})
			@nu = opts[:nu] || 0 #degrees of freedom
			@precision = opts[:precision] || 3
			@x = Vector.alloc( opts[:x] || [0] )
			super(opts)
		end

		def pdf
			@x.collect { |x| Ran::tdist_pdf(x, @nu).round(@precision) }
		end

		def cdf(lower_tail=true)
			method_to_call = if lower_tail
				:tdist_P
			else
				:tdist_Q
			end
			@x.collect { |x| Cdf.send(method_to_call,x, @nu).round(@precision) }
		end
	end
end