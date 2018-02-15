# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  let(:user) { build(:user) }

  describe "ActiveRecord associations" do
    it { expect(user).to belong_to(:facility) }
    it { expect(user).to belong_to(:rating) }

    it { expect(user).to have_many(:training_progress) }
  end

  describe "ActiveRecord validations" do
    # Basic validations
    it { expect(user).to validate_presence_of(:cid) }
    it { expect(user).to validate_presence_of(:first_name) }
    it { expect(user).to validate_presence_of(:last_name) }
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_presence_of(:reg_date) }

    # Format validations
    it { expect(user).to_not allow_value("").for(:cid) }
    it { expect(user).to_not allow_value("").for(:first_name) }
    it { expect(user).to_not allow_value("").for(:last_name) }
    it { expect(user).to_not allow_value("").for(:email) }
    it { expect(user).to_not allow_value("").for(:reg_date) }

    # Inclusion/acceptance of values
    it { expect(user).to validate_uniqueness_of(:cid) }
    it { expect(user).to validate_numericality_of(:cid).is_greater_than(0) }
  end
  # describe 'ActiveRecord validations'

  describe "ActiveRecord delegations" do
    it { expect(user).to delegate_method(:division).to(:facility) }
    it { expect(user).to delegate_method(:region).to(:division) }
  end

  describe "#to_s" do
    it "returns the full name and rating of a user" do
      first_name = user.first_name
      last_name  = user.last_name
      rating     = user.rating.short_name

      expect(user.to_s).to eq "#{first_name} #{last_name} (#{rating})"
    end
  end
end
