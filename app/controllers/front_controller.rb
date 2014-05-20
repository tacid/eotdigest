class FrontController < ApplicationController

  hobo_controller

  def index; end

  def summary
    if !current_user.administrator?
      redirect_to user_login_path
    end
  end

  def search
    if params[:query]
      site_search(params[:query])
    end
  end

  def clear_cache
    logger.info("Clearing cache...");
    Rails.cache.clear
    logger.info("Cache is clear");
    flash[:notice] = 'Кеш очищен'
    respond_to do |wants|
      wants.html { redirect_to "/"}
      wants.js { hobo_ajax_response || render(:nothing => true) }
    end
  end

end
