class CodesController < ApplicationController
  def index
  end

  def new
    @code = Code.new
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

  private

  def code_params
    params.require(:code).permit(:title, :body_html, :body_css, :body_js, :is_public)
  end
end
