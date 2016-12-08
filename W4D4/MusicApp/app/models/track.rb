# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  name       :string           not null
#  track_type :string
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  validates :album_id, :name, presence: true
  validates :track_type, inclusion: { in: %w(Regular Bonus), allow_nil: true }
  belongs_to :album

  has_one :band,
          through: :album,
          source: :band

  delegate :band_name,
          :title,
          to: :album,
          prefix: true
end
