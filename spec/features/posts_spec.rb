require "rails_helper"

RSpec.describe "Posts pages" do
  let(:author) { create(:user) }
  let(:connection) { create(:user, email: "connection@email.com") }
  let(:stranger) { create(:user, email: "stranger@email.com") }

  before do
    Connection.create(user: author, connection: connection, status: :accepted)
    Connection.create(user: connection, connection: author, status: :accepted)
  end

  describe "create new post" do
    before do
      login_as(author, scope: :user)
      visit new_post_path
    end

    context "visible to everyone" do
      it "has visibility set to 'everyone' and is visible to all users on the feed" do
        fill_in "post_content", with: "Post for everyone"
        select "everyone", from: "post_visibility"
        click_button "Post"

        post = Post.last
        expect(post.visibility).to eq("everyone")

        logout

        login_as(connection, scope: :user)
        visit feed_path
        expect(page).to have_content("Post for everyone")
        logout

        login_as(stranger, scope: :user)
        visit feed_path
        expect(page).to have_content("Post for everyone")
      end
    end

    context "visible to connections only" do
      it "has visibility set to 'connections' and is visible only to connections" do
        fill_in "post_content", with: "Post for connections"
        select "connections", from: "post_visibility"
        click_button "Post"

        post = Post.last
        expect(post.visibility).to eq("connections")

        logout

        login_as(connection, scope: :user)
        visit feed_path
        expect(page).to have_content("Post for connections")
        logout

        login_as(stranger, scope: :user)
        visit feed_path
        expect(page).not_to have_content("Post for connections")
      end
    end

    context "visible only to me" do
      it "has visibility set to 'onlyme' and is visible only to the author" do
        fill_in "post_content", with: "Private post"
        select "onlyme", from: "post_visibility"
        click_button "Post"

        post = Post.last
        expect(post.visibility).to eq("onlyme")

        logout

        login_as(connection, scope: :user)
        visit feed_path
        expect(page).not_to have_content("Private post")
        logout

        login_as(stranger, scope: :user)
        visit feed_path
        expect(page).not_to have_content("Private post")
        logout

        login_as(author, scope: :user)
        visit feed_path
        expect(page).to have_content("Private post")
      end
    end
  end
end
