require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "Post #create" do
    context "with invalid params" do
      it "validates the presence of the user's username and pasword" do
        post :create, params:{user: {username: "Mike", password: ""}}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates that the password is at least 6 characters long" do
        post :create, params: {user: {username: "Mike", password: "short"}}
        # save_and_open_page
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end
    context "with valid params" do
      it "redirects user to sign-in page on success" do
        post :create, params: {user: {username: "Mike", password: "7654321" }}
        user3 = User.find_by(username: "Mike")
        expect(response).to redirect_to(new_users_url)
      end
    end

  end
end
