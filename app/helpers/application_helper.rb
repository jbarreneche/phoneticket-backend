module ApplicationHelper
  def path_with_host(url)
    if url.starts_with? "/"
      "http://" + request.host_with_port + url
    else
      url
    end
  end

  def image_tag_for_report(*args)
    if report_as_html?
      image_tag(*args)
    else
      wicked_pdf_image_tag(*args)
    end
  end
end
