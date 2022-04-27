class PublicHolidayFacade
  def holiday_info
    PublicHoliday.new(service.holiday_data)
  end

  # def holiday_date
  #   PublicHoliday.new(service.holiday_data)
  # end

  def service
    PublicHolidayService.new
  end
end