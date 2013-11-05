ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
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
    end

    columns do
      column do
        panel "Entradas más vendidas por película" do
          semantic_form_for :report, url: admin_dashboard_sales_by_movie_path(format: :pdf), method: :get, as: false do |f|
            f.inputs do
              f.input(:min_date, label: "Fecha inicio", input_html: { class: "datepicker" , max: "10", value: Date.today.beginning_of_month }) <<
              f.input(:max_date, label: "Fecha fin", input_html: { class: "datepicker" , max: "10", value: Date.today.end_of_month })
            end <<
            f.actions do
              f.action :submit, as: :button, label: "Descargar"
            end
          end
        end
      end
      column do
        panel "Entradas más vendidas por hora" do
          semantic_form_for :report, url: admin_dashboard_sales_by_hour_path(format: :pdf), method: :get, as: false do |f|
            f.inputs do
              f.input(:min_date, label: "Fecha inicio", input_html: { class: "datepicker" , max: "10", value: Date.today.beginning_of_month }) <<
              f.input(:max_date, label: "Fecha fin", input_html: { class: "datepicker" , max: "10", value: Date.today.end_of_month })
            end <<
            f.actions do
              f.action :submit, as: :button, label: "Descargar"
            end
          end
        end
      end
    end
  end # content

  page_action :sales_by_hour do
    @min_date = Date.parse(report_params[:min_date] || "2013-01-01")
    @max_date = Date.parse(report_params[:max_date] || "2013-12-31")

    shows_stats = ActiveRecord::Base.connection.exec_query <<-SQL
      SELECT
        #{time_function('shows.starts_at')} AS time,
        theatres.name,
        COUNT(seats.id) AS count_seats
      FROM
        "shows"
      INNER JOIN
        "seats" ON "seats"."show_id" = "shows"."id"
      INNER JOIN
        "rooms" ON "rooms"."id" = "shows"."room_id"
      INNER JOIN
        "theatres" ON "theatres"."id" = "rooms"."theatre_id"
      WHERE
        "seats"."status" = 'purchased' AND
        ("shows"."starts_at" BETWEEN '#{@min_date.to_s(:db)}' AND '#{@max_date.to_s(:db)}')
      GROUP BY
        theatres.name, time
      ORDER BY
        time ASC, count_seats DESC
    SQL
    @shows_stats = shows_stats.rows

    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table.new_column('string', 'Película' )
    theatres = Theatre.pluck(:name)
    theatres.each do |theatre|
      data_table.new_column('number', theatre)
    end

    # Add Rows and Values
    stats_by_time = @shows_stats.group_by(&:first)
    times = (0..23).map {|h| "%02d:00" % h }
    times.each do |time|
      time_stats = stats_by_time.fetch(time, []).map {|arr| arr[1..2] }
      stats_by_theatre = Hash[time_stats]
      row = [time]
      theatres.each do |theatre|
        row.push stats_by_theatre.fetch(theatre, 0).to_i
      end
      data_table.add_rows [row]
    end

    opts   = { width: 800, height: 400, title: 'Horarios más vendidos', isStacked: true }
    @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)

    respond_to do |format|
      format.pdf do
        render pdf: "dashboard", layout: "pdf.html",
          show_as_html: params[:html].present?
      end
      format.html
    end
  end

  page_action :sales_by_movie do
    @min_date = Date.parse(report_params[:min_date] || "2013-01-01")
    @max_date = Date.parse(report_params[:max_date] || "2013-12-31")

    shows  = Show.where(starts_at: @min_date..@max_date)

    movies = Movie.all.joins(shows: :seats).merge(shows)
    movies_totals = movies
     .where(seats: {status: Seat::STATUS_PURCHASED})
     .group("movies.id").count("seats.id")

    shows_by_movie_id = shows.includes(:movie, room: :theatre).
      where(movies: {id: movies_totals.keys}).group_by(&:movie_id)

    @sale_stats = movies_totals.map do |movie_id, count|
      MovieSaleStat.new(shows_by_movie_id.fetch(movie_id), count)
    end.sort

    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table.new_column('string', 'Película' )
    data_table.new_column('number', 'Entradas vendidas')

    # Add Rows and Values
    data_table.add_rows @sale_stats.map(&:to_table_row)

    opts   = { width: 600, height: 400, title: 'Entradas vendidas por película', is3D: false }
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)

    respond_to do |format|
      format.pdf do
        render pdf: "dashboard", layout: "pdf.html",
          show_as_html: params[:html].present?
      end
      format.html
    end
  end

  controller do
    def report_params
      params.fetch(:report, {}).permit!
    end

    def time_function(column)
      # Format times and fix Buenos Aires Timezone
      case ActiveRecord::Base.connection.adapter_name
      when "SQLite"
        %{strftime('%H:00', #{column}, '-3 HOURS')}
      when "PostgreSQL"
        %{to_char(#{column} - time '03:00', 'HH24:00')}
      else
        raise "Unknown Adapter #{ActiveRecord::Base.connection.adapter_name} for time_function"
      end
    end
  end

  class MovieSaleStat
    attr_reader :sales_count, :movie, :shows
    include Comparable

    def initialize(shows, count)
      @shows = shows
      @movie = shows.first.movie
      @sales_count = count
    end

    def theatres
      @theatres ||= @shows.map {|show| show.room.theatre }.uniq
    end

    def to_table_row
      [@movie.title, sales_count]
    end

    def <=>(other)
      other.sales_count <=> sales_count
    end
  end
end
