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

      column do
        panel "Info" do
          link_to "Download!", admin_dashboard_sales_by_movie_path(format: :pdf)
        end
      end
    end
  end # content

  page_action :sales_by_movie do
    @min_date = Date.parse(params[:min_date] || "2013-01-01")
    @max_date = Date.parse(params[:max_date] || "2013-12-31")

    shows  = Show.where(starts_at: @min_date..@max_date)

    movies = Movie.scoped.joins(shows: :seats).merge(shows)
    movies_totals = movies.group("movies.id").count("seats.id")
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
