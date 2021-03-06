class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @mensores = @user.mensores
    @mensore = Mensore.new

  end

  def index
    @users = User.all
    @mensore = Mensore.new
    @user = User.find(current_user.id)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "変更できました。"
    else
      render "edit"
    end
  end
  
  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  def bookmarks
    bookmarks = Bookmark.where(user_id: @user.id).pluck(:mensore_id)
    @bookmarks_mensores = Mensore.find(bookmarks)
  end
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
