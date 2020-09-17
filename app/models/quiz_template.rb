class QuizTemplate < ApplicationRecord
  belongs_to :quizable, polymorphic: true
end
