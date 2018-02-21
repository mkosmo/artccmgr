# frozen_string_literal: true

require "rails_helper"

describe HomePolicy do
  subject { described_class.new(nil, nil) }

  context "visitors" do
    it { is_expected.to permit_action :index }

    it { is_expected.to forbid_action :destroy }
    it { is_expected.to forbid_new_and_create_actions  }
    it { is_expected.to forbid_edit_and_update_actions }
  end
end
