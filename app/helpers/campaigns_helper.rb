module CampaignsHelper
  def goal_options
    ['Reach',
     'Awareness',
     'Acquisition',
     'TBD']
  end

  def kpi_options
    ['Impressions',
     'Click Through Rate (CTR)',
     'Cost Per Acquisition (CPA)',
     'Video Completion Rate',
     'TBD']
  end

  def education_options
    ['Less than high school graduate',
     'High school graduate',
     'Some college or associates degree',
     'Bachelor’s degree',
     'Graduate or professional degree']
  end

  def parental_options
    ['Parent',
     'Not Parent']
  end

  def income_options
    ['<$50k',
     '$50-100k',
     '$100-200k',
     '$200-500k',
     '$500k+']
  end
end
