class Cat < ActiveRecord::Base
  COLORS = %w(brown black white orange)

  def self.colors
    COLORS
  end

  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: %w(M F) }

  def age
    (Date.today - birth_date).to_i / 365
  end

  has_many :cat_rental_requests, -> { order :start_date },
    dependent: :destroy
end
