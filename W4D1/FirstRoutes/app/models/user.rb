class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many :contacts,
    dependent: :destroy,
    foreign_key: :owner_id

  has_many :contact_shares,
    dependent: :destroy,
    foreign_key: :shared_user_id

  has_many :shared_contacts,
    through: :contact_shares,
    source: :contact
end
