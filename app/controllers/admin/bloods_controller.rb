class Admin::BloodsController < Admin::BaseController
  skip_load_and_authorize_resource
  authorize_resource History
  authorize_resource User

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
        avatar: u.avatar.try(:small).try(:url),
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
    @q = User.with_last_history.ransack ransack_params
    @users = @q.result
    @users = @users.decorate
    @users = User.sort_non_attribute @users, params[:q][:s] if params[:q] && params[:q][:s]
    @users = User.search_non_attribute @users, params[:q][:non_attr] if non_attr_query_present?
    @stats = calc_statistics @users
  end

  def calc_statistics users
    total = @users.size
    can_donate = @users.to_a.count {|user| user.can_donate?}
    {
      total: total,
      can_donate: can_donate,
      cannot_donate: total - can_donate
    }
  end
end
