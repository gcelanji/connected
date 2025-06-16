require "rails_helper"

RSpec.describe "Posts pages" do
  describe "create new post" do
    context "visible to everyone" do
      it "creates a post visible to all users" do
        visit new_post_path
        expect(page).to have_content("New Post")
      end
    end
  end
end