class FavoritesController < ApplicationController
    def create
        @favorite = current_user.favorites.new(code_id: params[:code_id])
      if @favorite.save
        redirect_to codes_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @favorite = current_user.favorites.find_by(code_id: params[:code_id])
      @favorite.destroy!
      redirect_to codes_path
    end
end
