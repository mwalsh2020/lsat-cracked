class Tag::Performance
  include Comparable
  include ActiveModel::Model
  attr_accessor :id, :slug, :total_count, :correct_count

  def tag
    @tag ||= Tag.find(id)
  end

  def value
    Rational(correct_count.to_i, denominator).to_f
  end

  def good?
    value > 0.7
  end

  def denominator
    correct_count.to_i.zero? ? 1 : total_count.to_i
  end

  def <=>(other)
    value <=> other.value
  end
end
