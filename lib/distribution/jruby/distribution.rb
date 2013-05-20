require 'java'

require_relative '../common_maths/commons-math3-3.2.jar'

java_import 'org.apache.commons.math3.analysis.function.Sqrt'
java_import 'org.apache.commons.math3.random.EmpiricalDistribution'
java_import 'org.apache.commons.math3.stat.descriptive.SummaryStatistics'

module Distribution
	module Utils
		def sqrt(v)
			Sqrt.new.value(v)
		end
	end
	#common math doesn't support histogram. but it does support Frequency or Empirical Distribution
	#http://commons.apache.org/proper/commons-math/apidocs/org/apache/commons/math3/stat/Frequency.html
	#http://commons.apache.org/proper/commons-math/apidocs/org/apache/commons/math3/random/EmpiricalDistribution.html
	class Histogram
		attr_accessor :data
		attr_reader :hist
		#as parameter you should pass an array or GSL::Vector
		def initialize(opts = {})
			@data = opts[:data] || []
			@num_bins = opts[:nbins] || 20
			@hist = EmpiricalDistribution.new(@num_bins)  
		end
		def gen
			#temporary
			@hist.load(data.to_java(Java::double))
			@hist
		end
		def plot
			raise HistogramUnkownException,"You didn't call gen before" if @hist.nil?
			IO.popen("graph -T X -g 3", "r+") do |graph|
				gen_histogram.each_with_index do |l,i|
					graph.printf("%e %e\n",i+=1,l)
				end
				graph.close_write
			end
		end
		def mean
			@hist.get_numerical_mean
		end

		private

		def gen_histogram
			histogram = []
			@hist.get_bin_stats.each_with_index do |stat,i|
				histogram[i] = stat.get_n
			end
			histogram
		end
	end
end