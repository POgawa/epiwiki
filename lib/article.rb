class Article < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tags
  has_many :revisions

  validates :name, presence: :true

end
