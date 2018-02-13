class MovieDecorator < Draper::Decorator
  delegate_all

  def name
    object.name.titleize
  end

  def release_date
    object.release_date.strftime("%d-%B-%Y")
  end

  def director
    object.director.titleize
  end

end
