class Revision < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  validates :content, presence: true
end
