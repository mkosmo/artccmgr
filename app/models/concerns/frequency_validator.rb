# frozen_string_literal: true

# Validates that a given frequency is compatible with the US aviation band plan.  118-135MHz, 12.5kHz spacing.
# Also permits for the use of the VATSIM "n/a" frequency of 199.998.
class FrequencyValidator < ActiveModel::Validator
  def validate(record)
    return if record.frequency.nil? or record.frequency.blank?
    # Allow use of VATSIM placeholder
    return if record.frequency.to_d == 199.998

    validate_type(record)
    validate_range(record)
    validate_steps(record)
  end

  def validate_type(record)
    unless record.frequency.is_a?(BigDecimal) || record.frequency.is_a?(Float)
      record.errors.add :frequency, "is an invalid type"
    end
  end

  def validate_range(record)
    unless (118..137).include? record.frequency.to_d
      record.errors.add :frequency, "is outside of the aviation band"
    end
  end

  def validate_steps(record)
    unless record.frequency.to_d % 0.0125 == 0
      record.errors.add :frequency, "is not compliant with 12.5KHz spacing"
    end
  end
end
