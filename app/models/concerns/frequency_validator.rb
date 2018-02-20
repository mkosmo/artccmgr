# frozen_string_literal: true

# Validates that a given frequency is compatible with the US aviation band plan.  118-135MHz, 12.5kHz spacing.
# Also permits for the use of the VATSIM "n/a" frequency of 199.998.
class FrequencyValidator < ActiveModel::Validator
  def validate(record)
    return if record.frequency.nil?
    return if record.frequency == ""

    unless record.frequency.is_a?(BigDecimal) || record.frequency.is_a?(Float)
      record.errors.add :frequency, "is an invalid type"
    end

    # Allow use of VATSIM placeholder
    return if record.frequency == 199.998

    unless (118..137).include? record.frequency.to_d
      record.errors.add :frequency, "is outside of the aviation band"
    end

    unless record.frequency.to_d % 0.0125 == 0
      record.errors.add :frequency, "is not compliant with 12.5KHz spacing"
    end
  end
end
