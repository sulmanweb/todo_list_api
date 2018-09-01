class ListsController < ApplicationController
  before_action :authenticate_user
  before_action :set_list, only: [:show, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
    @lists = current_user.lists.all.order(id: :desc)
    return success_list_index
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    return success_list_show
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = current_user.lists.build(list_params)

    if @list.save
      return success_list_create
    else
      return error_list_save
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    if @list.update(list_params)
      return success_list_show
    else
      return error_list_save
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    return success_list_destroy
  end

  protected

  def success_list_index
    render status: :ok, template: 'lists/index.json.jbuilder'
  end

  def success_list_show
    render status: :ok, template: 'lists/show.json.jbuilder'
  end

  def success_list_create
    render status: :created, template: 'lists/show.json.jbuilder'
  end

  def success_list_destroy
    render status: :no_content, json: {}
  end

  def error_list_save
    render status: :unprocessable_entity, json: {errors: @list.errors.full_messages}
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list = current_user.lists.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def list_params
    params.permit(:name)
  end
end
