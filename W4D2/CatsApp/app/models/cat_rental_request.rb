class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validate :valid_dates, :overlapping_approved_requests

  def valid_dates
    if start_date > end_date
      errors[:date_range] << "is invalid"
    end
  end

  def overlapping_requests
    CatRentalRequest.where("id != :id AND cat_id = :cat_id AND (start_date BETWEEN
      :start_date AND :end_date OR end_date BETWEEN :start_date AND
      :end_date)", id: id, cat_id: cat_id, start_date: start_date, end_date: end_date)
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def overlapping_approved_requests
    unless overlapping_requests.where("status = 'APPROVED'").empty?
      errors[:overlapping] << "requests for this cat"
    end
  end

  def pending?
    status == "PENDING"
  end

  def approve!
    transaction do
      self.status = "APPROVED"
      save
      overlapping_pending_requests.update_all(status: "DENIED")
    end
  end

  def deny!
    self.status = "DENIED"
    save
  end

  belongs_to :cat
end
