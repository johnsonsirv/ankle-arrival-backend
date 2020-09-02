class ChangeDateAndTimeColumnsToString < ActiveRecord::Migration[5.2]
  def change
    change_column :appointments, :appointment_date, :string
    change_column :appointments, :appointment_time, :string
  end
end
