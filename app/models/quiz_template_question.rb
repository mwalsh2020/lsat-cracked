class QuizTemplateQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :quiz_template
end
