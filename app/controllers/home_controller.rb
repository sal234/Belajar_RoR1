class HomeController < ApplicationController
    # Untuk skip check authentication semacam CSRF Token di Laravel
skip_before_action :verify_authenticity_token
# Handling ketika data not found saat update, dan delete
rescue_from ActiveRecord::RecordNotFound, with: :notFound


    def user_params
        params.permit(
            users: [:name, :phone]
            )
    end

    def notFound
        render json: {
            values: {},
            message: "Data tidak ditemukan!"
        }, status: 400
    end

    def index 
        @user = User.all 
        render json: {
            values: @user,
            message: "Sukses!" 
        }, status: 200
    end

    def show 
        @user = User.find_by_id(params[:id])
        if @user.present?
            render json: {
                values: @user,
                message: "Sukses!"
            }, status: 200
        else   
            render json: {
                values: "",
                message: "tidak dapat menemukan data"
            }, status: 400
        end
    end

    def create #method membuat user
        
        # Rails.logger.info("---------------------------")
        # Rails.logger.info(user_params)
        # byebug  
        user_params[:users].each do |user_param|
            user = User.create(user_param)
        end

        render json: {
            values: user_params,
            message: "Sukses"
        }, status: 200
    end
    
    def update #method update user
        @user = User.find(params[:id])

        if @user.update(user_params)
            render json: {
                values: {},
                message: "Sukses"
            }, status: 200
        else
            render json: {
                values: {},
                message: "gagal"
            }, status: 400
        end
    end

    def delete #method delete user
        @user = User.find(params[:id])

        if @user.destroy
            render json: {
                values: {},
                message: "Sukses"
            }, status: 200
        else
            render json: {
                values: {},
                message: "gagal"
            }, status: 400
        end
    end
end
