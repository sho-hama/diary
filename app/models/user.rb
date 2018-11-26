class User < ApplicationRecord
  validates :name, {presence: true} #空の検査
  validates :email, {presence: true, uniqueness: true} #空+重複なしの検査
  validates :password, {presence: true} #空の検査
  
end
