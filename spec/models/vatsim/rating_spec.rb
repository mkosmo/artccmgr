# frozen_string_literal: true

require "rails_helper"

RSpec.describe Vatsim::Rating, type: :model do
  it "has a valid factory" do
    expect(build(:vatsim_rating)).to be_valid
  end

  let(:rating) { build(:vatsim_rating) }

  describe "ActiveRecord associations" do
    it { expect(rating).to have_many(:ots_recommendations).dependent(:destroy) }
    it { expect(rating).to have_many(:training_blocks).dependent(:destroy) }
    it { expect(rating).to have_many(:users).dependent(:destroy) }
  end

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(rating).to validate_presence_of(:name) }
    it { expect(rating).to validate_presence_of(:short_name) }
    it { expect(rating).to validate_presence_of(:vatsim_id) }

    # Format validations
    it { expect(rating).to_not allow_value("").for(:name) }
    it { expect(rating).to_not allow_value("").for(:short_name) }
    it { expect(rating).to_not allow_value("").for(:vatsim_id) }

    # Inclusion/acceptance of values
    it { expect(rating).to validate_uniqueness_of(:name).case_insensitive }
    it { expect(rating).to validate_uniqueness_of(:short_name).case_insensitive }

    it { expect(rating).to validate_length_of(:short_name).is_at_most(3) }

    it { expect(rating).to validate_inclusion_of(:vatsim_id).in_range(0..100) }
  end
  # describe 'ActiveRecord validations'

  describe "#to_s" do
    it "displays the name and the short name of the rating" do
      expect(rating.to_s).to eq "#{rating.name} (#{rating.short_name})"
    end
  end
end
