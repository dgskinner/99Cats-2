class CatRentalRequest < ActiveRecord::Base
  validates :cat, :start_date, :end_date, :status, :requester, presence: true
  validates :status, inclusion: { in: %w(APPROVED DENIED PENDING),
    message: "%{value} is not a valid status" }
  validate :no_overlapping_approved_requests
  validate :request_is_chronological
  
  
  belongs_to :cat
  belongs_to(
    :requester,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  def approve!
    if self.status == "PENDING" && self.overlapping_approved_requests.empty?
      CatRentalRequest.transaction do
        overlapping_pending_requests.each do |request|
          request.deny!
        end
        self.status = "APPROVED"
        self.save!
      end
    else
      puts "No"
    end
  end
  
  def deny!
    self.status = "DENIED"
    self.save!
  end
  
  def pending?
    self.status == "PENDING"
  end
  
  def overlapping_requests
    CatRentalRequest
      .where(cat_id: self.cat_id)
      .where("start_date <= ? AND end_date >= ?", self.end_date, self.start_date)
      .where("? is NULL OR id != ?", self.id, self.id)
  end
  
  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end
  
  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end
  
  def no_overlapping_approved_requests
    unless overlapping_approved_requests.empty?
      errors[:date] << "overlaps with another request"
    end
  end
  
  def request_is_chronological
    errors[:date] << 'is backwards in time, wierdo.' unless self.start_date <= self.end_date
  end
  
end
