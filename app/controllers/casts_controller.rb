class CastsController < ApplicationController
  before_action :set_cast, only: [:show]

    def index
      @casts = Cast.where(publish: true).order('created_at ASC')
    end

    def show
      @cast.update_column('count_views', @cast.count_views + 1) if @cast.present?
    end

    private
    def set_cast
      @cast = Cast.where(publish: true).friendly.find(params[:id])
    end
end
