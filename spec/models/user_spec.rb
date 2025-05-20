require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "returns the full_name" do
    expect(user.full_name).to eq "John Doe"
  end
end
