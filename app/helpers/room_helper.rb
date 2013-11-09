module RoomHelper

  def human_shape(shape)
    I18n.t("room.shapes.#{shape}", default: shape.titleize) if shape
  end

  def shapes_collection
    Shape::CONFIGS.keys.map do |shape|
      [human_shape(shape), shape]
    end
  end

end
