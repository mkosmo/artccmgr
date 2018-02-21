# frozen_string_literal: true

require "rails_helper"

describe ApplicationPolicy do
  subject { described_class.new(nil, nil) }

  context "by default" do
    it { is_expected.to forbid_actions [:index, :show, :destroy] }
    it { is_expected.to forbid_new_and_create_actions  }
    it { is_expected.to forbid_edit_and_update_actions }
  end
end
