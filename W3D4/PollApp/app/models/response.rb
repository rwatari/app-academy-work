# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response

  belongs_to :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_choice_id

  belongs_to :respondent,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    self.sibling_responses.exists?(user_id: self.user_id)
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:respondent] << "has already answered this question"
    end
  end
end
