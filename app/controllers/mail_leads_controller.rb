class MailLeadsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @mail_lead = MailLead.new(mail_lead_params)
    authorize @mail_lead

    if @mail_lead.valid?
      User.invite!(mail_lead_params)
      redirect_to root_path, anchor: "mail-lead", notice: "Mail sent"
    else
      redirect_to root_path(invalid_mail: true, anchor: "mail-lead"), notice: "Mail invalid"
    end
  end

  private

  def mail_lead_params
    params.require(:mail_lead).permit(:email)
  end
end
