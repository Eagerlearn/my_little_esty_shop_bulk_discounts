class PublicHolidayService
  def holiday_data
    get_url("https://date.nager.at/api/v3/publicholidays/2017/AT")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end