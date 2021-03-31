class Tag::Data
  include ActiveModel::Model
  attr_accessor :id, :slug, :total_count, :correct_count

  def tag
    @tag ||= Tag.find(id)
  end

  def performance
    Rational(correct_count, total_count).to_f
  end
end
