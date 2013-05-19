require 'java'
require_relative '../common_maths/commons-math3-3.2.jar'
java_import 'org.apache.commons.math3.analysis.function.Sqrt'

module Distribution
	module Utils
		def sqrt(v)
			Sqrt.new.value(v)
		end
	end
end