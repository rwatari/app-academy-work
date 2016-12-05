class Contact < ActiveRecord::Base
  validates :name, :email, :owner_id, presence: true
  validates :email, uniqueness: { scope: :owner_id }

  belongs_to :owner, class_name: :User

  has_many :contact_shares, dependent: :destroy

  has_many :shared_users,
    through: :contact_shares,
    source: :shared_user
end
