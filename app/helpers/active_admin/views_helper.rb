module ActiveAdmin
  module ViewsHelper

    def human_weekdays(weekdays)
      Array(weekdays).map do |weekday|
        t("weekdays.#{weekday}")
      end
    end

  end
end
