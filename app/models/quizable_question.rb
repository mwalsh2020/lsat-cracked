class QuizableQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :quizable, polymorphic: true

  validates :quizable_id, uniqueness: { scope: [:question_id, :quizable_type] }
end
