require 'rails_helper'

RSpec.describe Doctor, type: :model do
  context 'validations' do
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:username) }
    it { is_expected.to validate_length_of(:username).
          is_at_least(3).is_at_most(16) }
      
     it 'validates uniqueness of username' do
      doctor1 = create(:doctor, username: 'default')
      doctor2 = build(:doctor, username: 'default')
      
      expect(doctor2).to_not be_valid
    end
     it 'validates uniqueness of email' do
      doctor1 = create(:doctor, email: 'default@yok.io')
      doctor2 = build(:doctor, email: 'default@yok.io')
      
      expect(doctor2).to_not be_valid
    end
  end

  context 'Associations' do
    it { should have_many(:appointments).dependent(:destroy) }
  end
end
