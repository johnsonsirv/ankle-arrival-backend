class CreateDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :city
      t.string :username

      t.timestamps
    end
  end
end
