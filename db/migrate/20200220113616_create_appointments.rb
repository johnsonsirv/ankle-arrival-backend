class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :doctor, foreign_key: true
      t.references :user, foreign_key: true
      t.text :description
      t.date :appointment_date
      t.time :appointment_time

      t.timestamps
    end
  end
end
