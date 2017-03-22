class Photo < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  belongs_to :upload

  attr_accessor :tag_list

  mount_uploader :image, ImageUploader
  validates_presence_of :image

  self.per_page = 20

  scope :nodesc, -> { where('photos.id NOT IN (SELECT photo_id from taggings) AND
                      photos.id NOT IN (SELECT photo_id from categorizations)') }

  scope :nodesc_for_upload, -> (upload_id) { where(upload_id: upload_id).nodesc }

  def tag_list
    self.tags.all.order('content').map { |t| t.content }.sort.join(' ')
  end

  def tag_list=(tags)
    t_arr = Array.new
    tags.split(' ').each_with_index do |t, i|
      if i < 10
        t_arr.push(Tag.find_or_create_by(content: t.downcase))
      end
    end
    self.tags = t_arr
  end
end
