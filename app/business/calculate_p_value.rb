class CalculatePValue
  def initialize(control_sends, test_sends, control_converted, test_converted)
    @control_sends = control_sends.to_f
    @test_sends = test_sends.to_f
    @control_converted = control_converted.to_f
    @test_converted = test_converted.to_f
  end

  def perform
    begin
      control_conversion_rate = @control_converted / @control_sends
      control_standard_error = Math.sqrt((control_conversion_rate * (1 - control_conversion_rate) / @control_sends))

      test_conversion_rate = @test_converted / @test_sends
      test_standard_error = Math.sqrt((test_conversion_rate * (1 - test_conversion_rate) / @test_sends))
      z_score = (control_conversion_rate - test_conversion_rate) / Math.sqrt(((control_standard_error ** 2) + (test_standard_error ** 2)))

      p_value = calculate_cdf(z_score)
      return (1 - p_value) * 100
    rescue
      return "Please check values"
    end
  end

  private

  def calculate_cdf(x)
   t = 1 / (1 + 0.2316419 * x.abs)
   d = 0.3989423 * Math.exp((-x * x)/2)
   prob = d * t * (0.3193815 + t * (-0.3565638 + t * (1.781478 + t * (-1.821256 + t * 1.330274))))
   if x > 0
     return (1 - prob)
   else
     return prob
   end
  end
end
