class Admin::BloodsController < Admin::BaseController
  before_action :set_form, :load_data

  def index
    @users = Kaminari.paginate_array(@users).page(params[:page]).per 10
  end

  def maps
    @center = {}
    if params[:map]
      @radius = params[:map][:radius]
      @center = params[:map][:center]
    end
    @radius ||= Settings.default_radius
    @users = @users.map do |u|
      {
        id: u.id,
        name: u.name,
        avatar: u.avatar&.small.url,
        status: u.status,
        position: {
          lat: u.lat,
          lng: u.lon
        }
      }
    end.to_json
  end

  protected
  def set_form
    @form =  Support::UserForm.new
  end

  def non_attr_query_present?
    params[:q].present? && params[:q][:non_attr].present? && !params[:q][:non_attr].values.include?("")
  end

  def load_data
    ransack_params = params[:q].except :non_attr if params[:q].present?
    @q = User.includes(:histories).ransack ransack_params
    @users = @q.result.decorate
    @users = User.sort_non_attribute @users, params[:q][:s] if params[:q] && params[:q][:s]
    @users = User.search_non_attribute @users, params[:q][:non_attr] if non_attr_query_present?
  end
end
