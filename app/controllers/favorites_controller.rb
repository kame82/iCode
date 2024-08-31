class FavoritesController < ApplicationController
    def create
      @favorite = current_user.favorites.new(code_id: params[:code_id])
      if @favorite.save
        flash[:notice] = t('flash.favorite.create')
        redirect_to codes_path
      else
        flash[:alert] = t('flash.favorite.create_error')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @favorite = current_user.favorites.find_by(code_id: params[:code_id])
      @favorite.destroy!
      flash[:notice] = t('flash.favorite.destroy')
      redirect_to codes_path
    end
end
