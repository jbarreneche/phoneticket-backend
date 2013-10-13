ActiveAdmin.register Movie do
  menu priority: 2

  filter :title
  filter :synopsis
  filter :youtube_trailer
  filter :created_at
  filter :updated_at

  index as: :grid, columns: 5 do |movie|
    h3 do
      text_node link_to(movie.title, admin_movie_path(movie))
      span(class: "small") do
        link_to "(editar)", edit_admin_movie_path(movie)
      end
    end
    div do
      link_to(image_tag(movie.cover_url(:admin), size: "120x160"), admin_movie_path(movie))
    end
  end

  show do |movie|
    attributes_table do
      row :id
      row :title
      row :synopsis
      row :director
      row :cast do
        movie.cast.to_sentence
      end
      row :genre do
        human_genre(movie.genre)
      end
      row :audience_rating
      row(:price_setting) { movie.price_setting.try(:name) }
      row :youtube_trailer do
        if movie.youtube_trailer?
          link_to movie.youtube_trailer
        else
          em "No se cargó ningún video de youtube"
        end
      end
      row :cover do
        if movie.cover.present?
          image_tag(movie.cover_url(:admin), size: "120x160")
        else
          em "No se cargó una imagen"
        end
      end
    end
  end

  form do |f|
    f.inputs "Película" do
      f.input :title
      f.input :synopsis
      f.input :youtube_trailer
      f.input :director
      f.input :cast_raw, as: :text, required: true, hint: "Cada actor debe ir en una línea separada"
      f.input :audience_rating, collection: audience_ratings_collection
      f.input :genre, collection: genres_collection
      f.input :cover
      f.input :price_setting
    end

    f.buttons
  end

  after_destroy :check_model_errors

  controller do
    def permitted_params
      params.permit movie: [
        :title, :synopsis, :youtube_trailer, :cover,
        :director, :cast_raw, :audience_rating, :genre,
        :price_setting_id
      ]
    end

   def check_model_errors(object)
      return unless object.errors.any?
      flash[:error] ||= []
      flash[:error].concat(object.errors.full_messages)
    end
  end
end
