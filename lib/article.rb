class Article < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tags
  has_many :revisions
  validates :name, presence: :true
  validates :content, presence: :true

  before_save :downcase_content_and_name

  def revision? article
    self.name == article.name
  end

  def ==(other)
    self.name == other.name && self.content == other.content
  end

private

  def downcase_content_and_name
    self.content.downcase!
    self.name.downcase!
  end

end
