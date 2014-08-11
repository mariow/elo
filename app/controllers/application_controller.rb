class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :active_league
  before_filter :load_players
  before_filter :authorize_by_ip
  WHITELIST = ['46.244.213.211', '212.114.195.242', '83.243.114.5'].freeze

  private

  def active_league
    League.first
  end

  def load_players
    @players ||= Player.all(:order => "doubles_rank DESC")
  end

  def authorize_by_ip
    unless( WHITELIST.include? request.remote_ip )
      render :file => "#{Rails.public_path}/401.html", :status => :unauthorized, :request => request
    return
  end
end

end
