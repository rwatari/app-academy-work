# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  title      :string           not null
#  album_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ActiveRecord::Base
  validates :band_id, :title, presence: true
  validates :album_type, inclusion: { in: %w(Studio Live), allow_nil: true }

  belongs_to :band

  has_many :tracks, dependent: :destroy

  delegate :name, to: :band, prefix: true
end
