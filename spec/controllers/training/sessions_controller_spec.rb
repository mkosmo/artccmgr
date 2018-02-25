# frozen_string_literal: true

require "rails_helper"

RSpec.describe Training::SessionsController, type: :controller do

  describe "GET #index" do
    context "unauthenticated user" do
      it "redirects to the show page" do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    context "when logged in" do
      before :each do
        @user = create(:user)
        sign_in @user

        create_list(:training_session, 5, user: @user)
        get :index
      end

      it "populates a list of training sessions" do
        expect(assigns(:sessions)).to_not be_empty
      end

      it "renders the index template" do
        expect(response).to render_template :index
      end
    end
  end

  describe "POST #create" do
    context "unauthenticated user" do
      before :each do
        @session = build(:training_session)
      end

      it "does not create a training session" do
        expect{
          post :create, params: { training_session: @session.attributes }
        }.to_not change(Training::Session, :count)
      end

      it "redirects to the root page" do
        post :create, params: { training_session: @session.attributes }
        expect(response).to redirect_to root_path
      end
    end

    context "authenticated user" do
      context "with valid attributes" do
        before :each do
          @instructor = create(:user)
          sign_in @instructor
          @session = build(:training_session)

          @attributes = @session.attributes
          @attributes["notes_attributes"] = { "0" => attributes_for(:training_note) }
        end

        it "creates a training session" do
          expect{
            post :create, params: { training_session: @attributes }
          }.to change(Training::Session, :count)
        end

        it "redirects to the show page" do
          post :create, params: { training_session: @attributes }
          session = Training::Session.find_by(user: @session.user)
          expect(response).to redirect_to training_session_path(session)
        end
      end
    end

    context "with invalid attributes" do
      before :each do
        @instructor = create(:user)
        sign_in @instructor
        @session = build(:training_session)
        @session.user = nil

        @attributes = @session.attributes
        @attributes["notes_attributes"] = { "0" => attributes_for(:training_note) }
      end

      it "does not create a training session" do
        expect{
          post :create, params: { training_session: @attributes }
        }.to_not change(Training::Session, :count)
      end

      it "re-renders the new view" do
        post :create, params: { training_session: @attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    context "unauthenticated user" do
      before :each do
        session = create(:training_session)
        get :edit, params: { id: session.id }
      end

      it "redirects to the show page" do
        expect(response).to redirect_to root_path
      end
    end

    context "authenticated user" do
      before :each do
        @session = create(:training_session)
        @instructor = create(:user)
        sign_in @instructor
        get :edit, params: { id: @session.id }
      end

      it "assigns the @session" do
        expect(assigns(:session)).to eq @session
      end

      it "renders the edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "GET #new" do
    context "unauthenticated user" do
      before :each do
        get :new
      end

      it "redirects to the show page" do
        expect(response).to redirect_to root_path
      end
    end

    context "authenticated user" do
      before :each do
        @instructor = create(:user)
        sign_in @instructor
        get :new
      end

      it "assigns a new training @session" do
        expect(assigns(:session)).to be_kind_of Training::Session
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end
  end

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

  describe "DELETE #destroy" do
    context "unauthenticated user" do
      before :each do
        @session = create(:training_session)
      end

      it "does not delete the training session" do
        expect{
          delete :update, params: { id: @session.id }
        }.to_not change(Training::Session, :count)
      end

      it "redirects to the root page" do
        delete :update, params: { id: @session.id }
        expect(response).to redirect_to root_path
      end
    end

    context "authenticated user" do
      before :each do
        @session = create(:training_session)
        @instructor = create(:user)
        sign_in @instructor
      end

      it "destroys the Training Session" do
        expect{
          delete :destroy, params: { id: @session.id }
        }.to change(Training::Session, :count)
      end

      it "redirects to the Training Session index" do
        delete :destroy, params: { id: @session.id }
        expect(response).to redirect_to training_sessions_path
      end
    end
  end
  # describe "DELETE #destroy"

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
