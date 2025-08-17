require 'rails_helper'

RSpec.describe Author, type: :model do
  # validate associations, author can have many books
  it { should have_many(:books) }

  # validate fields
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  # Validate model factory
  it "has a valid factory" do
    expect(build(:author)).to be_valid
  end
end
