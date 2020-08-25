class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def registerable?
    return false unless self.class.methods.include?(:devise_modules)

    self.class.devise_modules.include?(:registrations)
  end
end
