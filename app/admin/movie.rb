ActiveAdmin.register Movie do
  menu priority: 2

  controller do
    def permitted_params
      params.permit movie: [
        :title, :synopsis, :youtube_trailer
      ]
    end
  end
end
