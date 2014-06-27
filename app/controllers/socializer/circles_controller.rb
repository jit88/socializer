#
# Namespace for the Socializer engine
#
module Socializer
  class CirclesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_circle, only: [:show, :edit, :update, :destroy]

    # GET /circles
    def index
      @circles = current_user.circles
    end

    # GET /circles/1
    def show
      @users = Person.all
    end

    # GET /circles/new
    def new
      @circle = Circle.new
    end

    # GET /circles/1/edit
    def edit
    end

    # POST /circles
    def create
      @circle = current_user.circles.build(params[:circle])
      @circle.save!
      redirect_to circles_contacts_path
    end

    # PATCH/PUT /circles/1
    def update
      @circle.update!(params[:circle])
      redirect_to @circle
    end

    # DELETE /circles/1
    def destroy
      @circle.destroy
      redirect_to circles_contacts_path
    end

    # GET /circles/contacts
    def contacts
      @circles = current_user.circles
    end

    # GET /circles/contact_of
    def contact_of
      @circles = current_user.circles
    end

    # GET /circles/find_people
    def find_people
      @circles = current_user.circles
    end

    private

    def set_circle
      @circle = current_user.circles.find_by(id: params[:id])
    end
  end
end
