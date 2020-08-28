class Course::ApplicationController < ApplicationController
  before_action :set_chapters
  layout "course"

  private

  def set_chapters
    @chapters = policy_scope(Chapter)
  end
end
