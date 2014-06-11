class RegionsController < ApplicationController

  hobo_model_controller

  auto_actions :all, except: [ :new ]

  def index
    regions = Region.includes(:users).includes(:records).search(params[:search], :name).
                        order_by(parse_sort_param(:name))
    hobo_index regions
  end

end
