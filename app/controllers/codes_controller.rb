class CodesController < ApplicationController
  before_action :private_code_access?, only: [:show, :edit]
  before_action :others_edit_access?, only: [:edit]

  def index
    @codes = Code.eager_load(:user)
                 .where(is_public: "public") # 公開コードのみ表示
                 .or(Code.eager_load(:user).where(user_id: current_user.id)) # 自分のコードも表示
                 .order(created_at: :desc)
  end

  def show
    @code = Code.find(params[:id])
    @favorite = current_user.favorites.find_by(code_id: @code.id)
  end

  def new
    @code = Code.new
  end

  def edit
    @code = Code.find(params[:id])
    @favorite = current_user.favorites.find_by(code_id: @code.id)

    # 他人のコードを表示する場合は、詳細ページにリダイレクトする
    unless user_owns_code?(@code)
      redirect_to code_path(@code)
    end
  end

  def create
    @code = Code.new(code_params)
    @code.user = current_user

    if @code.save
      flash[:notice] = t('flash.code.create')
      redirect_to codes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @code = Code.find(params[:id])
    if @code.update(code_params)
      flash[:notice] = t('flash.code.update')
      redirect_to codes_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @code = Code.find(params[:id])
    @code.destroy!
    flash[:notice] = t('flash.code.destroy')
    redirect_to codes_path
  end

  private

  def code_params
    # is_publicをintegerに変換してparamsにセットする
    params[:code][:is_public] = params[:code][:is_public].to_i if params[:code][:is_public]
    params.require(:code).permit(:title, :body_html, :body_css, :body_js, :is_public, :image)
  end

  def user_owns_code?(code)
    code.user_id == current_user.id
  end

  def private_code_access?
    @code = Code.find(params[:id])
    if @code.is_public == "private"  && !user_owns_code?(@code)
      flash[:alert] = t('flash.code.private')
      redirect_to codes_path
    end
  end

  def others_edit_access?
    @code = Code.find(params[:id])
    if !user_owns_code?(@code)
      flash[:alert] = t('flash.code.private')
      redirect_to codes_path
    end
  end

end
