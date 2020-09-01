class User::Guest
  def id
    nil
  end

  def admin?
    false
  end

  def present?
    false
  end

  def guest?
    true
  end

  def paying?
    false
  end

  def registerable?
    User.new.registerable?
  end
end
