class Creative < ApplicationRecord
  belongs_to :campaign
  mount_uploader :file, CreativeUploader

  def filetype
    return 'image' if file.content_type.include?('image')
    return 'video' if file.content_type.include?('video')
    return 'audio' if file.content_type.include?('audio')
    return 'document' if file.content_type.include?('application') || file.content_type.include?('text')
    'other'
  end

  def name
    file.url.gsub(/^.*[\\\/]/, "").split('?')[0]
  end

  def shortname
    n = name
    if n.length > 25
      return n[0..24] + "..."
    end
    n
  end
end
