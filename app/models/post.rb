class Post < ActiveRecord::Base
  acts_as_votable
  acts_as_commontable
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  validates :title, presence: true, length: {minimum: 4, maximum: 10000}
  validates :link, presence: true, length: {minimum: 4, maximum: 10000}
  validates :user_id, presence: true
  
  scope :not_deleted, lambda { where(deleted_at: nil) }
  scope :deleted, lambda { where("#{self.table_name}.deleted_at IS NOT NULL") }
  
  def destroy
    self.update_attributes(deleted_at: DateTime.current)
  end

  def delete
    destroy
  end

  def deleted?
    self.deleted_at.present?
  end
  
end
