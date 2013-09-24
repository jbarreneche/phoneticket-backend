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

  controller do
    def permitted_params
      params.permit movie: [
        :title, :synopsis, :youtube_trailer, :cover
      ]
    end
  end
end
