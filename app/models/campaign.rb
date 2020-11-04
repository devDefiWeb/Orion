class Campaign < ApplicationRecord
  has_one :company_campaign, dependent: :destroy
  has_many :campaign_segments
  has_many :segments, through: :campaign_segments

  validates :name, presence: true

  accepts_nested_attributes_for :audiences

  def company
    company_campaign.company
  end
end
