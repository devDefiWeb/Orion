class CampaignsController < ApplicationController
  before_action :set_advertiser
  before_action :set_campaign, only: [:edit, :update, :destroy]

  include ErrorMessages

  def index
    @campaigns = @advertiser&.campaigns
  end

  def show
    @campaign = Campaign.find(params[:id])
    @website = 'www.website.com'
    @button_links = {
        back: advertiser_campaigns_path(advertiser_id: @advertiser.id),
        edit: "#{request.path}/edit",
        duplicate: '#',
        delete: "#{request.path}"
    }
  end

  def new
    @campaign = @advertiser.campaigns.new
  end

  def create
    @campaign = @advertiser.campaigns.new(campaign_params.merge(status: "pending_approval"))
    if @campaign.save
      request_type = request_type_params.to_sym
      send_internal_notification(request_type)
      send_customer_confirmation(request_type)

      redirect_to advertiser_campaigns_path(advertiser_id: @advertiser.id),
                  notice: 'Campaign has been successfully created.'
    else
      render json: {messages: display_validation(@campaign), redirectTo: '', status: 422}
    end
  end

  def edit
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to advertiser_campaigns_path(advertiser_id: @advertiser.id),
                  notice: 'Campaign has been successfully updated.'
    else
      errors = {alert: {danger: @campaign.errors.full_messages.join(', ')}}
      redirect_to advertiser_campaigns_path(advertiser_id: @advertiser.id),
                  errors
    end
  end

  def destroy
    if @campaign.destroy
      flash[:notice] = 'Campaign successfully deleted'
    else
      flash[:alert] = 'Unable to remove campaign'
    end

    redirect_to advertiser_campaigns_path(advertiser_id: @advertiser.id)
  end

  private

  def set_advertiser
    @advertiser = Advertiser.find(params[:advertiser_id])
  end

  def set_campaign
    @campaign = @advertiser.campaigns.find_by(id: params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(
        :name,
        :campaign_url,
        :start_date,
        :end_date,
        :goal,
        :kpi,
        :conversion_rate,
        :average_order_value,
        :target_cpa,
        :target_roas,
        :budget,
        {:age_range_male => []},
        {:age_range_female => []},
        {:household_income => []},
        :education,
        :parental_status,
        {:geography => []},
        :affinities => {}
    )
  end

  def request_type_params
    params.require(:request_type)
  end

  def send_internal_notification(request_type)
    CampaignMailer.internal_notification(current_user,
                                         @campaign,
                                         @company,
                                         request_type).deliver_later
  end

  def send_customer_confirmation(request_type)
    CampaignMailer.customer_confirmation(current_user,
                                         @campaign,
                                         @company,
                                         request_type).deliver_later
  end
end
