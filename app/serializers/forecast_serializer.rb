class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :full_forecast
end
