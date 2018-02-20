# frozen_string_literal: true

require "rails_helper"

RSpec.describe OmniauthCallbacksController, type: :controller do
  before :all do
    OmniAuth.config.test_mode = true
  end

  describe "#failure" do
    before :each do
      OmniAuth.config.on_failure = proc { |env|
        OmniAuth::FailureEndpoint.new(env).redirect_to_failure
      }

      OmniAuth.config.mock_auth[:vatsim] = :invalid_credentials

      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"]  = OmniAuth.config.mock_auth[:vatsim]
    end

    it "does not sign in a user" do
      get :vatsim
      expect(warden.authenticated?(:user)).to eq false
    end

    it "sets a flash message" do
      get :vatsim
      expect(controller).to set_flash[:notice]
    end

    it "redirects to the root_path" do
      get :vatsim
      expect(response).to redirect_to root_path
    end
  end # describe '#failure'

  describe "#vatsim" do
    before :each do
      create(:vatsim_rating, vatsim_id: 5)
      OmniAuth.config.mock_auth[:vatsim] = OmniAuth::AuthHash.new(
        provider: "vatsim",
        uid: 9_999_999,
        info: {
            id:         9_999_999,
            name_first: "John",
            name_last:  "Doe",
            rating: {
                id:     "5",
                short:  "C1",
                long:   "Controller 1",
                GRP:    "Controller"
            },
            email:      "noreply@example.com",
            experience: "N",
            reg_date:   Time.now.utc,
            country:      { code: "US", name: "United States"  },
            region:       { code: "NA", name: "North America"  },
            division:     { code: "NA", name: "North America"  },
            subdivision:  { code: "USA", name: "United States" }
        }
      )

      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"]  = OmniAuth.config.mock_auth[:vatsim]
    end

    context "with a new user" do
      it "should create a new user object" do
        expect { get :vatsim }.to change { User.count }.by(1)
      end

      it "should update the new user object with VATSIM SSO data" do
        get :vatsim
        user = User.find_by(cid: 9_999_999)
        expect(user.first_name).to  eq "John"
        expect(user.last_name).to   eq "Doe"
        expect(user.email).to       eq "noreply@example.com"
        expect(user.reg_date).to    be <= Time.now.utc
        expect(user.initials).to    be_nil
        expect(user.rating).to      eq Vatsim::Rating.find_by(vatsim_id: 5)
      end
    end # context 'with new user'

    context "with an existing user" do
      before :each do
        User.destroy_all
        @user = create(:user, cid: 9999999)
      end

      it "should find an existing user object" do
        get :vatsim
        expect(assigns :user).to eq @user
      end

      it "should reconcile any changes trusting the VATSIM SSO data" do
        get :vatsim
        @user.reload
        expect(@user.first_name).to eq "John"
        expect(@user.last_name).to  eq "Doe"
        expect(@user.email).to      eq "noreply@example.com"
        expect(@user.reg_date).to   be <= Time.now.utc
        expect(@user.rating).to     eq Vatsim::Rating.find_by(vatsim_id: 5)
      end
    end # context "with an existing user"

    it "should sign in the user" do
      get :vatsim
      expect(warden.authenticated?(:user)).to eq true
    end

    it "should redirect to the root page" do
      get :vatsim
      expect(response).to redirect_to root_path
    end
  end

end
