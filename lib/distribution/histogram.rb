require 'gnuplot'
# the class use gnuplot to calculate frequency and draw a histogram 
# limitations: the step is the same in this code. it can not be used to draw histogram with different steps.
module Distribution
  class Histogram
    def h_class(x)
      ((x-@min)/@step).truncate
    end
	 
    # array is the raw data, step is used when calculate frequency
    def initialize(array, step)
      @min = (array.min - 0.5).round
      @fix_boxes_offset = step.to_f / 2.0
      @x = []; @x << @min + @fix_boxes_offset
      max = array.max
      while @x[-1] <= (max - @fix_boxes_offset)
        @x << @x[-1] + step
      end
      @max = @x[-1]; @step = step
      @y = Array::new(h_class(@max)+1, 0)
      array.each{|i| push i}
    end
 
    def push(x)
      # if x<@min or @max<x then return; end;
      @y[h_class([[@min,x].max, @max].min)]+=1
      self
    end
	 
    def plot(fig_name="histogram", fig_dir=".", x_lab="", y_lab="", i_xtics=10, 
      i_file="postscript eps color enhanced", i_size="0.5,0.5", i_style="fill solid 0.5 border")
      @y << 0
      Gnuplot.open do |gp|
       Gnuplot::Plot.new( gp ) do |plot|
         plot.term i_file
	 plot.output "#{fig_dir}/#{fig_name}"
	 plot.autoscale
	 plot.size i_size
	 plot.xrange "[#{@x[0] - @fix_boxes_offset - 1}:#{@x[-1] + @fix_boxes_offset + 1}]"
	 plot.xtics "#{i_xtics}"
	 plot.yrange "[0:#{@y.max * 1.1}]"
	 plot.notitle
	 plot.xlabel x_lab
	 plot.ylabel y_lab
	 plot.style  i_style
	 plot.data = [  
	   Gnuplot::DataSet.new([@x, @y]) do |ds|
	      ds.with = "boxes"
	      ds.title = "step = #{@step}"
	   end 
	 ]
       end
      end
    end
  end
end
