class CastsController < ApplicationController
  before_action :set_cast, only: [:show]

    def index
      @casts = Cast.where(publish: true).order('created_at ASC')
    end

    def show
    end

    private
    def set_cast
      @cast = Cast.where(publish: true).friendly.find(params[:id])
    end
end
