# frozen_string_literal: true

require "rails_helper"

RSpec.describe Training::ProfilesController, type: :controller do

  describe "GET #show" do
    context "unauthenticated user" do
      it "redirects to the show page" do
        get :show
        expect(response).to redirect_to root_path
      end
    end

    context "when logged in" do
      before :each do
        @user = create(:user)
        sign_in @user
      end

      it "populates the user's last 5 training sessions" do
        create_list(:training_session, 10, user: @user)
        get :show
        expect(assigns(:sessions).size).to eq 5
      end

      it "renders the show view" do
        get :show
        expect(response).to render_template :show
      end
    end
  end
  # describe "GET #show"

end
