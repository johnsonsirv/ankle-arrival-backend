require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:username) }
   it { should validate_presence_of(:firstname) }
   it { should validate_presence_of(:lastname) }
    it { is_expected.to validate_length_of(:username).
          is_at_least(3).is_at_most(16) }
    it { is_expected.to have_secure_password }
    
    it 'validates uniqueness of username' do
      user1 = create(:user, username: 'default')
      user2 = build(:user, username: 'default')
      
      expect(user2).to_not be_valid
    end
     it 'validates uniqueness of email' do
      user1 = create(:user, email: 'default@yok.io')
      user2 = build(:user, email: 'default@yok.io')
      
      expect(user2).to_not be_valid
    end
  end

  context 'Associations' do
    it { should have_many(:appointments).dependent(:destroy) }
  end
end
