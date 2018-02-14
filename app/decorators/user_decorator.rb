class UserDecorator < ApplicationDecorator
  delegate_all

  %i[first_name last_name city state country].each do |field_name|
    define_method(field_name) do
      eval("object.#{field_name.to_s}.titleize")
    end
  end

  def address
    object.address.humanize
  end

end
