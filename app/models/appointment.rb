class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user
  
  validates_presence_of :description, :appointment_date, :appointment_time
  validate :appointment_date_is_valid
  
  
  private
	def appointment_date_is_valid
		if appointment_date && appointment_date < Date.today
			errors.add(:appointment_date, 'appointment_date should not be in the past  ')
		end
	end
end
