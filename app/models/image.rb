class Image < ActiveRecord::Base
  attr_accessible :file, :attachable, :is_default
  
  has_attached_file :file, 
    :styles => { 
      :large => "500x500>", 
      :medium => "300x300>", 
      :small => "100x100>", 
      :small_thumb => "100x100#", 
      :thumb => "50x50#", 
      :avatar => "138x138#"
    }

  validates_attachment_content_type :file, :content_type => %w(image/jpeg image/jpg image/png)

  belongs_to :attachable, :polymorphic => true

  delegate :path, :url, :content_type, :to => :file
end
