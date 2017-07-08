class Ajax::HistoriesController < BaseController
  before_action :load_history, only: :show

  def show
    @history = @history.decorate if @history
  end

  private
  def load_history
  @history = History.find_by_id params[:id]
  end
end
