class FavoritesController < ApplicationController
    def create
      @favorite = current_user.favorites.new(code_id: params[:code_id])
      if @favorite.save
        flash[:notice] = "いいねしました" #あとで削除する
        redirect_to codes_path
      else
        flash[:alert] = "いいねに失敗しました" #あとで削除する
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @favorite = current_user.favorites.find_by(code_id: params[:code_id])
      @favorite.destroy!
      flash[:notice] = "いいねを解除しました" #あとで削除する
      redirect_to codes_path
    end
end
