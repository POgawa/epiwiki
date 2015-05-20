class Tag < ActiveRecord::Base
  has_and_belongs_to_many :articles
  validates :topic, presence: :true
  
  before_save :downcase_topic

private

  def downcase_topic
    self.topic.downcase!
  end

end
