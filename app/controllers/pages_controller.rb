class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :testimonials]
  before_action :skip_authorization, only: [:home, :about, :testimonials]

  def home
    @mail_lead = MailLead.new
  end

  def about; end
  def testimonials; end
end
