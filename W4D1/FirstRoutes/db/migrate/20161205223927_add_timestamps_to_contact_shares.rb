class AddTimestampsToContactShares < ActiveRecord::Migration
  def change
    add_column(:contact_shares, :created_at, :datetime)
    add_column(:contact_shares, :updated_at, :datetime)
  end
end
