class ErrorMessagesController < ApplicationController
  include Filterable
  before_action :authenticate_user!
  before_action :set_error_message, only: %i[ show edit update destroy ]

  def index
    @error_messages = ErrorMessage.all
  end

  def new
    html = render_to_string(partial: 'form', locals: { error_message: ErrorMessage.new })
    render operations: cable_car
      .inner_html('#slideover-content', html: html)
      .text_content('#slideover-header', text: 'Create new error message')
  end

  def edit
    html = render_to_string(partial: 'form', locals: { error_message: @error_message })
    render operations: cable_car
      .inner_html('#slideover-content', html: html)
      .text_content('#slideover-header', text: 'Update error message')
  end

  def create
    @error_message = ErrorMessage.new(error_message_params)
    if @error_message.save
      html = render_to_string(partial: 'error_message', locals: { error_message: @error_message })
      render operations: cable_car
        .prepend('#error_messages', html: html)
        .dispatch_event(name: 'submit:success')
    else
      html = render_to_string(partial: 'form', locals: { error_message: @error_message })
      render operations: cable_car
        .inner_html('#error-message-form', html: html), status: :unprocessable_entity
    end
  end

  def update
    if @error_message.update(error_message_params)
      html = render_to_string(partial: 'error_message', locals: { error_message: @error_message })
      render operations: cable_car
        .replace(dom_id(@error_message), html: html)
        .dispatch_event(name: 'submit:success')
    else
      html = render_to_string(partial: 'form', locals: { error_message: @error_message })
      render operations: cable_car
        .inner_html('#error-message-form', html: html), status: :unprocessable_entity
    end
  end

  def destroy
    @error_message.destroy
    render operations: cable_car.remove(selector: dom_id(@error_message))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_error_message
      @error_message = ErrorMessage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def error_message_params
      params.require(:error_message).permit(:status_code, :reference, :message)
    end

end