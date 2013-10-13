ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      # span :class => "blank_slate" do
      #   span I18n.t("active_admin.dashboard_welcome.welcome")
      #   small I18n.t("active_admin.dashboard_welcome.call_to_action")
      # end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Precios" do
          table do
            thead do
              tr do
                th
                th "Adulto"
                th "Niño"
                th "Días c/descuento"
                th "Adulto c/descuento"
                th "Niño c/descuento"
              end
            end
            tbody do
              PriceSetting.all.map do |price_setting|
                tr do
                  td { link_to price_setting.name, edit_admin_price_setting_path(price_setting) }
                  td number_to_currency(price_setting.adult)
                  td number_to_currency(price_setting.kid)
                  td human_weekdays(price_setting.discount_days).to_sentence
                  td number_to_currency(price_setting.adult_with_discount)
                  td number_to_currency(price_setting.kid_with_discount)
                end
              end
            end
          end
        end
      end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    end
  end # content
end
