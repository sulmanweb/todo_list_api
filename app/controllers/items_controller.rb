class ItemsController < ApplicationController
  before_action :authenticate_user
  before_action :set_list
  before_action :set_item, only: [:show, :update, :destroy, :change_status]

  # GET /items
  # GET /items.json
  def index
    @items = @list.items.all.order(id: :desc)
    return success_item_index
  end

  # GET /items/1
  # GET /items/1.json
  def show
    return success_item_show
  end

  # POST /items
  # POST /items.json
  def create
    @item = @list.items.build(item_params)
    @item.user = current_user

    if @item.save
      return success_item_create
    else
      return error_item_save
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    if @item.update(item_params)
      return success_item_show
    else
      return error_item_save
    end
  end

  def change_status
    @item.change_status!
    return success_item_show
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    return success_item_destroy
  end

  protected

  def success_item_index
    render status: :ok, template: 'items/index.json.jbuilder'
  end

  def success_item_show
    render status: :ok, template: 'items/show.json.jbuilder'
  end

  def success_item_create
    render status: :created, template: 'items/show.json.jbuilder'
  end

  def success_item_destroy
    render status: :no_content, json: {}
  end

  def error_item_save
    render status: :unprocessable_entity, json: {errors: @item.errors.full_messages}
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_list
    @list = current_user.lists.find(params[:list_id])
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.permit(:name)
  end
end
