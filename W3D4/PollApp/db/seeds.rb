# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user1 = User.create!(username: "rwatari")
user2 = User.create!(username: "jthomas")
user3 = User.create!(username: "pollster")

poll1 = Poll.create!(
  title: "Let's talk about life",
  author_id: user3.id
)

poll2 = Poll.create!(
  title: "Ruby Topics",
  author_id: user3.id
)

q1 = Question.create!(
  text: "What is the answer to life?",
  poll_id: poll1.id
)
q2 = Question.create!(
  text: "Have you had a good life?",
  poll_id: poll1.id
)

q3 = Question.create!(
  text: "Are blocks useful?",
  poll_id: poll2.id
)

a1 = AnswerChoice.create!(
  text: "47",
  question_id: q1.id,
)

a2 = AnswerChoice.create!(
  text: "42",
  question_id: q1.id,
)

a3 = AnswerChoice.create!(
  text: "Yes",
  question_id: q2.id,
)

a4 = AnswerChoice.create!(
  text: "Not really",
  question_id: q2.id,
)

a5 = AnswerChoice.create!(
  text: "Yes",
  question_id: q3.id,
)

a6 = AnswerChoice.create!(
  text: "Not really",
  question_id: q3.id,
)

Response.create!(
  user_id: 1,
  answer_choice_id: a2.id
)

Response.create!(
  user_id: 2,
  answer_choice_id: a3.id
)

Response.create!(
  user_id: 1,
  answer_choice_id: a3.id
)

Response.create!(
  user_id: 2,
  answer_choice_id: a5.id
)

Response.create!(
  user_id: 1,
  answer_choice_id: a5.id
)
