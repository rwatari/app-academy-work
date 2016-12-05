class ContactShare < ActiveRecord::Base
  validates :shared_user_id, :contact_id, presence: :true
  validates :contact_id, uniqueness: { scope: :shared_user_id }

  belongs_to :shared_user, class_name: :User

  belongs_to :contact
end
