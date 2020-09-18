class QuizableQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :quizable, polymorphic: true
end
