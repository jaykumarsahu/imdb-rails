class Product < ApplicationRecord

  def self.json_data
    self.all.map{ |p| p.as_json(except: [:created_at, :updated_at]) }
  end
end
