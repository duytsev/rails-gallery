class Photo < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :upload

  attr_accessor :tag_list

  mount_uploader :image, ImageUploader

  self.per_page = 20

  def tag_list
    self.tags.all.order('content').map{|c| c.content}.sort.join(' ')
  end

  def tag_list=(tags)
    t_arr = Array.new
    tags.split(' ').each_with_index do |t, i|
      if i < 5
        t_arr.push(Tag.find_or_create_by(content: t.downcase))
      end
    end
    self.tags = t_arr
  end
end
