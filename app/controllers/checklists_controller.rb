# encoding: UTF-8
class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy, :done]
  add_breadcrumb I18n.t('activerecord.models.checklists'), :checklists_path
  def index
    @search = Checklist.search(params[:q])
     @checklists = @search.result(:distinct => true).paginate(:page => params[:page])
     respond_with(@checklists)
  end

  def show
    add_breadcrumb @checklist.card, checklist_path(@checklist)
    respond_with(@checklist)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_checklist_path
    @checklist = Checklist.new
    respond_with(@checklist)
  end

  def edit
    add_breadcrumb @checklist.id, checklist_path(@checklist)
    add_breadcrumb t('tooltips.edit'), edit_checklist_path
  end

  def create
    @checklist = Checklist.new(checklist_params)
    @checklist.save
    @checklist_percentage = get_percentage(@checklist.card)
    respond_to do |format|
      format.js
    end
  end

  def update
    @checklist.update(checklist_params)
    respond_with(@checklist)
  end

  def destroy
    @checklist.destroy
    @checklist_percentage = get_percentage(@checklist.card)
    respond_to do |format|
      format.js
    end
  end

  def done
    if @checklist.done?
      @checklist.done =  false
      @checklist.done_at = nil
    else
      @checklist.done_at = Time.now
      @checklist.done =  true
    end
    @checklist.save!
    @checklist_percentage = get_percentage(@checklist.card)
    respond_to do |format|
      format.js
    end
  end

  private

  def set_checklist
    @checklist = Checklist.find(params[:id])
  end

  def checklist_params
    params.require(:checklist).permit(:card_id, :done, :done_at, :title)
  end
end
