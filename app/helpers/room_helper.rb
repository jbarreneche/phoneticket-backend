module RoomHelper

  def human_shape(shape)
    I18n.t("room.shapes.#{shape}", default: shape.titleize) if shape
  end

end
