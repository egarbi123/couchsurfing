class Api::UsersController < ApplicationController
    def create
        @user = User.new(user_params)
    
        if @user.save
            sign_in!(@user)
            render :show
        else
            render json: @user.errors.full_messages, status: 422
        end
    end

    def update
        @user = User.find(params[:id])
        if (@user)
            if @user.update(post_params)
                render :show
            else
                render json: @post.errors.full_messages, status: 422
            end
        else
            render json: ["User not found"], status: 404
        end
    end
    
    def index
        @users = User.all
        render :index 
    end

    private

    def user_params
        params.require(:user).permit(
            :name, 
            :password, 
            :email
        )
    end

end