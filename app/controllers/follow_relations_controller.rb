# frozen_string_literal: true

class FollowRelationsController < ApplicationController
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_to user_path(@user), notice: t('controllers.follow_relation.notice_follow')
  end

  def destroy
    current_user.unfollow(@user)
    redirect_to user_path(@user), notice: t('controllers.follow_relation.notice_unfollow')
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
