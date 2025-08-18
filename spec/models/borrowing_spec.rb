require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  # Associations
  it { should belong_to(:user) }
  it { should belong_to(:book) }

  # Validations
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:book) }

  it 'has a valid model factory' do
    expect(build(:borrowing, user: user, book: book)).to be_valid
  end
end
