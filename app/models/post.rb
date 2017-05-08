class Post < ActiveRecord::Base
  validates :title, presence: true, length: {maximum: 10000}
  validates :link, presence: true, length: {maximum: 10000}
end
