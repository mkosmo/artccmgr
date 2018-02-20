class Setting < ApplicationRecord
  audited

  validates :key,
            presence:     true,
            allow_blank:  false,
            uniqueness:   { case_sensitive: false }

  def to_s
    key
  end

end
