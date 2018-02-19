# frozen_string_literal: true

class FrequencyValidator < ActiveModel::Validator
  def validate(record)
    if (record.frequency.nil?)
      record.errors.add(:frequency, "is nil")
      return
    end

    if ((record.frequency.to_d < 118) || (record.frequency.to_d > 137)) && (record.frequency != 199.998)
      record.errors.add(:frequency, "is outside of the aviation band")
    end

    unless record.frequency.to_d % 0.0125 == 0
      record.errors.add(:frequency, "is not compliant with 12.5KHz spacing")
    end
  end
end
