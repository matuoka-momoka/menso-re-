class MensoresController < ApplicationController

  def show
    @mensore = Mensore.find(params[:id])
    @mensore_comment = MensoreComment.new
    @bookmark = @mensore.bookmarks.find_by(user_id: current_user.id)
    @user = User.find(current_user.id)
  end
  
  def index
    @mensores = Mensore.all
    @mensore = Mensore.new
  end

  def create
    @mensore = Mensore.new(mensore_params)
    @mensore.user_id = current_user.id
    if @mensore.save
      redirect_to mensore_path(@mensore)
    else
      @mensores = Mensore.all
      render 'index'
    end
  end

  def edit
    @mensore = Mensore.find(params[:id])
  end

  def update
    @mensore = Mensore.find(params[:id])
    if @mensore.update(mensore_params)
      redirect_to mensore_path(@mensore), notice: "できたよー."
    else
      render "edit"
    end
  end

  def destroy
    @mensore = Mensore.find(params[:id])
    @mensore.destroy
    redirect_to user_path(current_user)
  end
  
  private

  def mensore_params
    params.require(:mensore).permit(:title, :body,:image,:star)
  end

  def ensure_correct_user
    @mensore = Mensore.find(params[:id])
    unless @Mensore.user == current_user
      redirect_to mensores_path
    end
  end
end
