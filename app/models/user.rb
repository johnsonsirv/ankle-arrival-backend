class User < ApplicationRecord
  before_save :to_lower_case
  has_many :appointments, dependent: :destroy
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_presence_of :email, :city, :username, :firstname, :lastname
  validates :email, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :username, length: {in: 3..16}, uniqueness: { case_sensitive: false }

  has_secure_password
  
  def all_appointments
    appointments
      .joins('INNER JOIN users ON users.id = appointments.user_id
            INNER JOIN doctors on doctors.id = appointments.doctor_id')
      .select('users.username, users.email,users.firstname, users.lastname,
            doctors.firstname as doctor_firstname,
            doctors.lastname as doctor_lastname,
            doctors.email as doctor_email,
            appointments.appointment_date as date_of_appointment,
            appointments.appointment_time as time_of_appointment,
            appointments.description, appointments.id')
    .order(updated_at: :desc)
  end
 

  private

    def to_lower_case
      self.email = email.downcase
      self.username = username.downcase
    end
end
