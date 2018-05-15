require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(username: 'Mike', password: '123456') }



      context 'Creating new user with valid params'
      it { should validate_length_of(:password).is_at_least(6)}
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }

      it "creates a session token before validation" do
        user.valid?
        expect(user.session_token).to_not be_nil
      end

      describe "#reset_session_token!" do
        it 'sets a new session_token on the user' do
          user.valid?
          old_session_token = user.session_token
          user.reset_session_token!

          expect(user.session_token).to_not eq(old_session_token)
        end

        it 'returns the new session_token' do
          expect(user.reset_session_token!).to eq(user.session_token)
        end
      end

    let(:user) { User.create(username: 'Mike', password: '123456') }
    context 'Creating and storying  new user with valid params'
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    # it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_presence_of(:password_digest) }

    it "should run BCrypt" do
      expect(BCrypt::Password).to receive(:create).with('1234567')
     user2 = User.create(username: 'Mike', password: '1234567')
   end

    it "should find the correct user with credentials" do
      user2 = User.create(username: 'Mike', password: '1234567')
     user_found = User.find_by_credentials('Mike','1234567')
     expect(user2).to eq(user_found)
   end



end
