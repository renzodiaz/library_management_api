require 'rails_helper'

RSpec.describe Book, type: :model do
  # Associations
  it { should belong_to(:author) }

  # Validate fields
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:genre) }
  it { should validate_presence_of(:isbn) }

  it { should validate_uniqueness_of(:isbn) }

  # Validate model factory
  it 'has a valid factory' do
    expect(build(:book)).to be_valid
  end
end
