ActiveAdmin.register Movie do
  menu priority: 2

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

  controller do
    def permitted_params
      params.permit movie: [
        :title, :synopsis, :youtube_trailer, :cover
      ]
    end
  end
end
