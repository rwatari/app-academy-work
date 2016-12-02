# == Schema Information
#
# Table name: users
#
#  id       :integer          not null, primary key
#  username :string           not null
#

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many :authored_polls,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :author_id

  has_many :responses,
    class_name: :Response,
    primary_key: :id,
    foreign_key: :user_id

  def completed_polls
    user_response_poll_assoc
      .having('COUNT(DISTINCT questions.id) = COUNT(user_responses.id)')
  end

  def uncompleted_polls
    user_response_poll_assoc
      .having('COUNT(user_responses.id) BETWEEN 1 AND (COUNT(DISTINCT questions.id) - 1)')
  end

  def user_response_poll_assoc
    Poll.joins(questions: :answer_choices)
      .joins(<<-SQL)
        LEFT JOIN(
          SELECT *
          FROM responses
          WHERE user_id = #{self.id}
          ) AS user_responses
          ON user_responses.answer_choice_id = answer_choices.id
      SQL
      .group('polls.id')
  end

end
