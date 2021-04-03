class Tag::Performance
  include ActiveModel::Model
  attr_accessor :id, :slug, :total_count, :correct_count

  def object
    @object ||= Tag.find(id)
  end

  def value
    Rational(correct_count.to_i, total_count.to_i).to_f
  end
end
