module Quizable
  extend ActiveSupport::Concern

  included do
    has_many :quizzes, as: :quizable, dependent: :destroy
    has_many :quizable_questions, as: :quizable, dependent: :destroy
    has_many :questions, through: :quizable_questions
    accepts_nested_attributes_for :questions, reject_if: :all_blank,
                                              allow_destroy: true

    scope :with_questions, -> { joins(:questions).distinct }
  end
end
