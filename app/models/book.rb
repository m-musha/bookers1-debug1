class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user

  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  def save_books(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete = Tag.find_by(tag_name: old_name)
    end

    new_tags.each do |new_name|
      book_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << book_tag
    end
  end

end
