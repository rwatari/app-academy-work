# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  has_many :answer_choices,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :question_id

  belongs_to :poll,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :poll_id

  has_many :responses,
    through: :answer_choices,
    source: :responses

  # def results
  #   answers = self.answer_choices
  #
  #   response_counts = Hash.new(0)
  #   answers.each do |answer|
  #     response_counts[answer.text] = answer.responses.count
  #   end
  #
  #   response_counts
  # end

  # def results
  #   answers = self.answer_choices.includes(:responses)
  #
  #   response_counts = Hash.new(0)
  #   answers.each do |answer|
  #     response_counts[answer.text] = answer.responses.length
  #   end
  #
  #   response_counts
  # end

  def results
    result_counts = answer_choices.select('answer_choices.text, COUNT(responses.id) as choice_count')
      .joins('LEFT JOIN responses ON responses.answer_choice_id = answer_choices.id')
      .group('answer_choices.id')
      response_counts = Hash.new(0)

    result_counts.each do |answer|
      response_counts[answer.text] = answer.choice_count
    end

    response_counts

  end

  # SELECT answer_choices.text, COUNT(responses.id) AS choice_count
  # FROM questions
  # JOIN answer_choices ON answer_choices.question_id = questions.id
  # LEFT JOIN responses ON responses.answer_choice_id = answer_choices.id
  # WHERE questions.id = 3
  # GROUP BY answer_choices.text
end
