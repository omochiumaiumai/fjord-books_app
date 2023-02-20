# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user = User.new(email: 'alice@example.com', name: '')

    user.name = 'Alice'
    assert_equal 'Alice', user.name_or_email
  end

  test '#follow' do
    alice = users(:Alice)
    bob = users(:Bob)

    assert_not alice.active_relationships.where(following_id: bob.id).exists?

    alice.follow(bob)
    assert alice.active_relationships.where(following_id: bob.id).exists?
  end

  test '#unfollow' do
    alice = users(:Alice)
    bob = users(:Bob)

    assert_not alice.active_relationships.where(following_id: bob.id).exists?

    alice.follow(bob)
    assert alice.active_relationships.where(following_id: bob.id).exists?

    alice.unfollow(bob)
    assert_not alice.active_relationships.where(following_id: bob.id).exists?
  end

  test '#following?' do
    alice = users(:Alice)
    bob = users(:Bob)

    assert_not alice.following?(bob)
    Relationship.create(following_id: bob.id, follower_id: alice.id)
    assert alice.following?(bob)
  end

  test '#followed_by' do
    alice = users(:Alice)
    bob = users(:Bob)

    assert_not alice.followed_by?(bob)
    Relationship.create(following_id: alice.id, follower_id: bob.id)
    assert alice.followed_by?(bob)
  end
end
