class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email,              null: false#, unique: true, index: true
      t.string :password_digest,    null: false
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :city
      t.string :country
      t.string :zip
      t.string :state
      t.string :address
      t.timestamps
    end
  end
end
