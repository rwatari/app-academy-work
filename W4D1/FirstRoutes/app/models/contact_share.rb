# == Schema Information
#
# Table name: contact_shares
#
#  id             :integer          not null, primary key
#  contact_id     :integer          not null
#  shared_user_id :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#

class ContactShare < ActiveRecord::Base
  validates :shared_user_id, :contact_id, presence: :true
  validates :contact_id, uniqueness: { scope: :shared_user_id }

  belongs_to :shared_user, class_name: :User

  belongs_to :contact
end
