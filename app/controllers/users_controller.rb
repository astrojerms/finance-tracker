class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user
  end

  def my_friends
    @friendships = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend]).reject { |f| f == current_user}
      if !@friends.empty?
        respond_to do |format|
          format.js { render partial: 'users/friend_result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "User not found."
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a user"
        format.js { render partial: 'users/friend_result' }
      end
    end
  end
end
