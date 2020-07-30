require 'rails_helper'

RSpec.describe Appointment, type: :model do
  context 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:appointment_date) }
    it { should validate_presence_of(:appointment_time) }
    
    it 'is valid with valid attributes' do
      @appointment = create(:appointment)
      expect(@appointment).to be_valid
    end
    it 'invalid with past appoitnment date' do
			appointment = build(:appointment, appointment_date: Date.yesterday)

			# expect(appointment).to_not be_valid
		end
  end

  context 'Associations' do
    it { should belong_to(:doctor) }
    it { should belong_to(:user) }
  end
end
