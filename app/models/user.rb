class User < ApplicationRecord
  validates :name, {presence: true} #空の検査
  validates :email, {presence: true, uniqueness: true} #空+重複なしの検査
  validates :password, {presence: true} #空の検査

  def posts
    return Post.where(user_id: self.id)
  end
end
