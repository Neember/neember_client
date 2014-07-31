require 'rails_helper'

describe Admin do
  context 'validations' do
    it { should validate_presence_of :email }
  end

  let(:admin){ build(:admin) }

  it 'validates email address' do
    admin.email = 'martin@futureworkz.com'
    expect(admin.valid?).to be_truthy
    admin.email = 'martin124@gmail.com'
    expect(admin.valid?).to be_falsey
    admin.email = 'martin.com'
    expect(admin.valid?).to be_falsey
  end

  describe '.find_for_google_oauth2' do
    let(:access_token) { double('access_token') }
    before do
      allow(access_token).to receive(:info).and_return(
                               {'email' => admin.email})
    end

    context 'user has the account' do
      let!(:admin) { create(:admin) }

      it 'returns user has google authenticated' do
        expect { Admin.find_for_google_oauth2(access_token) }.to_not change(Admin, :count)
      end
    end

    context 'user does not have the account' do
      let(:admin) { build(:admin) }

      it 'creates a new user' do
        expect { Admin.find_for_google_oauth2(access_token) }.to change(Admin, :count).by(1)
      end
    end
  end
end

