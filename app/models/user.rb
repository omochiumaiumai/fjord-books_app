# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :active_relationships, class_name: 'FollowRelation', foreign_key: :follower_id, dependent: :destroy, inverse_of: :follower
  has_many :followings, through: :active_relationships, source: :following

  has_many :passive_relationships, class_name: 'FollowRelation', foreign_key: :following_id, dependent: :destroy, inverse_of: :following
  has_many :followers, through: :passive_relationships, source: :follower

  paginates_per 10

  def follow(user)
    active_relationships.find_or_create_by(following_id: user.id)
  end

  def following?(user)
    active_relationships.where(following_id: user.id).exists?
  end

  def unfollow(user)
    active_relationships.find_by(following_id: user.id)&.destroy
  end

  def followed?(user)
    passive_relationships.where(follower_id: user.id).exists?
  end
end
