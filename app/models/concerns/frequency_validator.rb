# frozen_string_literal: true

class FrequencyValidator < ActiveModel::Validator
  def validate(record)
    return if record.frequency.nil?

    # Allow use of VATSIM placeholder
    return if record.frequency == 199.998

    if (record.frequency.to_d < 118) || (record.frequency.to_d > 137)
      record.errors.add :frequency, "is outside of the aviation band"
    end

    unless (record.frequency.to_d % 0.0125 == 0)
      record.errors.add :frequency, "is not compliant with 12.5KHz spacing"
    end
  end
end
