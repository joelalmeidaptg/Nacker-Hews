class Post < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
  validates :title, presence: true, length: {minimum: 4, maximum: 10000}
  validates :link, presence: true, length: {minimum: 4, maximum: 10000}
  validates :user_id, presence: true
end
