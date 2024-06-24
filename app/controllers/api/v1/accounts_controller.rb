class Api::V1::AccountsController < Api::V1::ApiController
  def show
    @account = Account.find(params[:id])
  end
end
