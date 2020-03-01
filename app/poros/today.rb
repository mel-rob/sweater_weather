class Today

  def self.info(forecast_data)
    {
      today_summary: forecast_data[:hourly][:summary],
      tonight_summary: self.tonight(forecast_data[:hourly][:data]),
      high: forecast_data[:daily][:data][0][:temperatureHigh],
      low: forecast_data[:daily][:data][0][:temperatureLow],
      date: Time.now.to_date
    }
  end

private

  def self.tonight(hour_data)
    hour_8 = hour_data.find do |hour|
      Time.at(hour[:time]).in_time_zone('UTC').hour == 20
    end
    hour_8 ? hour_8[:summary] : hour_data[0][:summary]
  end
end
