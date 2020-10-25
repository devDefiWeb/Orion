class CampaignMailer < ApplicationMailer

  def internal_notification(user, campaign, type)
    @user = user
    @campaign = campaign
    @company = campaign.company
    type_titles = {recommendation: 'Recommendation', insertion_order: "Campaign IO"}

    mail(to: 'strategy@theversion2.com',
         subject: "#{type_titles[type]} Request",
         from: 'Version2 Strategy <strategy@theversion2.com>')
  end

  def customer_confirmation(user, campaign, type)
    @user = user
    @type = type
    type_titles = {recommendation: 'Recommendation', insertion_order: "IO"}

    mail(to: user.email,
         subject: "#{type_titles[type]} Confirmation - ##{campaign.id}",
         from: 'Version2 Strategy <strategy@theversion2.com>')
  end
end
