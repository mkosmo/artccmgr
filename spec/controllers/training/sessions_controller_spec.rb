# frozen_string_literal: true

require "rails_helper"

RSpec.describe Training::SessionsController, type: :controller do

  describe "GET #show" do
    context "unauthenticated user" do
      before :each do
        session = create(:training_session)
        get :show, params: { id: session.id }
      end

      it "redirects to the show page" do
        expect(response).to redirect_to root_path
      end
    end

    context "when logged in" do
      before :each do
        @user = create(:user)
        @session = create(:training_session, user: @user)
        sign_in @user
        get :show, params: { id: @session.id }
      end

      it "populates the user's training session" do
        expect(assigns(:session)).to eq @session
      end

      it "renders the show view" do
        expect(response).to render_template :show
      end
    end
  end
  # describe "GET #show"

  describe "PUT #update" do
    context "unauthenticated user" do
      before :each do
        @session = create(:training_session)
        put :update, params: { id: @session.id, training_session: @session.attributes }
      end

      it "redirects to the show page" do
        expect(response).to redirect_to root_path
      end
    end

    context "authenticated user" do
      before :each do
        @instructor = create(:user)
        sign_in @instructor
      end

      context "with invalid attributes" do
        before :each do
          @session = create(:training_session)
          @session.user = nil
          put :update, params: { id: @session.id, training_session: @session.attributes }
        end

        it "does not update the training session" do
          @session.reload
          expect(@session.user).to_not eq nil
        end

        it "renders the show page" do
          expect(response).to render_template :show
        end
      end

      context "with valid attributes" do
        before :each do
          @session = create(:training_session)
          @user    = create(:user)
          @session.user = @user
          put :update, params: { id: @session.id, training_session: @session.attributes }
        end

        it "updates the training session" do
          @session.reload
          expect(@session.user).to eq @user
        end

        it "redirects to the show page" do
          expect(response).to redirect_to training_session_path(@session)
        end
      end

      context "it accepts nested attributes for training notes" do
        before :each do
          @session = create(:training_session)
          put :update, params: { id: @session.id, training_session: { notes_attributes: { "1" => attributes_for(:training_note) } } }
        end

        it "updates the training notes for the session" do
          @session.reload
          expect(@session.notes.count).to eq 2
        end

        it "redirects to the show page" do
          expect(response).to redirect_to training_session_path(@session)
        end
      end
    end
    # context "authenticated user"
  end
  # describe "PUT #update"

end
