module ApplicationHelper
  def path_with_host(url)
    if url.starts_with? "/"
      "http://" + request.host_with_port + url
    else
      url
    end
  end

end
