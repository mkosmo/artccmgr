# frozen_string_literal: true

require "rails_helper"

RSpec.describe Training::Ots::Recommendation, type: :model do
  it "has a valid factory" do
    expect(build(:training_ots_recommendation)).to be_valid
  end

  let(:recommendation) { build(:training_ots_recommendation) }

  describe "ActiveRecord associations" do
    it { expect(recommendation).to belong_to(:user) }
    it { expect(recommendation).to belong_to(:instructor) }
    it { expect(recommendation).to belong_to(:rating) }
    it { expect(recommendation).to have_one(:result) }
  end

  describe "ActiveRecord validations" do
    # Basic validations

    # Format validations

    # Inclusion/acceptance of values
  end
  # describe 'ActiveRecord validations'

  describe "#pending" do
    before :each do
      create_list(:training_ots_recommendation, 5)
    end

    it "returns recommendations that do not have associated results" do
      expect(Training::Ots::Recommendation.pending.count).to eq 5
    end

    it "does not return recommendations that have results" do
      create_list(:training_ots_result, 2)
      expect(Training::Ots::Recommendation.pending.count).to eq 5
    end
  end

  describe "#permit_not_passed" do
    it "is not valid if the user has already passed an OTS for the rating" do
      ots_result = create(:training_ots_result, pass: true)

      new_ots = build :training_ots_recommendation,
                      user:   ots_result.user,
                      rating: ots_result.rating

      expect(new_ots).to_not be_valid
    end
  end

  describe "#permit_only_higher_rating" do
    it "is not valid for a rating lower than the user already has" do
      usr_rating = create(:vatsim_rating, vatsim_id: 3)
      ots_rating = create(:vatsim_rating, vatsim_id: 2)
      user       = create(:user, rating: usr_rating)

      ots = build(:training_ots_recommendation, user: user, rating: ots_rating)
      expect(ots).to_not be_valid
    end
  end

  describe "#permit_only_one" do
    it "is not valid if a user has an existing pending recommendation" do
      user = create(:user)
      create(:training_ots_recommendation, user: user)
      expect(build(:training_ots_recommendation, user: user)).to_not be_valid
    end
  end

  describe "#training_blocks_completed" do
    before :each do
      @user = create(:user)
    end

    it "is not valid if a user has not completed all training blocks for the rating" do
      rating = create(:vatsim_rating)
      create(:training_block, rating: rating)
      expect(build(:training_ots_recommendation, rating: rating)).to_not be_valid
    end

    it "is valid if a user has completed all training blocks for a rating" do
      user   = create(:user)
      rating = create(:vatsim_rating)
      block  = create(:training_block, rating: rating)

      create(:training_progress, user: user, block: block, completed_at: Time.now.utc)
      expect(build(:training_ots_recommendation, rating: rating, user: user)).to be_valid
    end
  end
end
