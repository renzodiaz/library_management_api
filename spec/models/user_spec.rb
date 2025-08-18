require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity  }
  it { should validate_presence_of(:password)  }

  it 'generates the confirmation token' do
    user.valid?
    expect(user.confirmation_token).to_not be nil
  end

  it 'downcases email before save' do
    user.email = "John@example.com"
    expect(user.valid?).to be true
    expect(user.email).to eq 'john@example.com'
  end

  it 'has a valid model factory' do
    expect(build(:user)).to be_valid
  end
end
