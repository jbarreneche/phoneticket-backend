ActiveAdmin.register Movie do
  controller do
    def permitted_params
      params.permit movie: [
        :title, :synopsis, :youtube_trailer
      ]
    end
  end
end
