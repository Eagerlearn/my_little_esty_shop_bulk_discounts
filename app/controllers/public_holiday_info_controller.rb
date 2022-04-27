class PublicHolidayInfoController < ApplicationController
  def show
    @holiday = PublicHolidayFacade.new.holiday_info
    # @date = PublicHolidayFacade.new.holiday_info
  end
end