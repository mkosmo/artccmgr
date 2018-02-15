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

    it 'returns recommendations that do not have associated results' do
      expect(Training::Ots::Recommendation.pending.count).to eq 5
    end

    it 'does not return recommendations that have results' do
      create_list(:training_ots_result, 2)
      expect(Training::Ots::Recommendation.pending.count).to eq 5
    end
  end
end
