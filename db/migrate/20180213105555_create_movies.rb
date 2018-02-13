class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.date :release_date
      t.string :director
      t.jsonb :cast, default: []
      t.timestamps
    end
  end
end
