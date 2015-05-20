class Article < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tags
  has_many :revisions
  validates :name, presence: :true
  validates :content, presence: :true

  before_save :downcase_content_and_name

private

  def downcase_content_and_name
    self.content.downcase!
    self.name.downcase!
  end
end
