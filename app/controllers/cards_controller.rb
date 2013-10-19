# encoding: UTF-8
class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  add_breadcrumb I18n.t('activerecord.models.cards'), :cards_path
  def index
    @search = Card.search(params[:q])
     @cards = @search.result(:distinct => true).paginate(:page => params[:page])
     respond_with(@cards)
  end

  def show
    add_breadcrumb @card.owner_id, card_path(@card)
    respond_with(@card)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_card_path
    @card = Card.new
    respond_with(@card)
  end

  def edit
    add_breadcrumb @card.id, card_path(@card)
    add_breadcrumb t('tooltips.edit'), edit_card_path
  end

  def create
    @card = Card.new(card_params)
    @card.save
    respond_with(@card)
  end

  def update
    @card.update(card_params)
    respond_with(@card)
  end

  def destroy
    @card.destroy
    respond_with(@card)
  end

  private

  def set_card
    @card = @current_project.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:assignment_id, :body, :checklist_done_count, :checklist_total_count, :comment_count, :document_count, :done, :due_date, :list, :owner_id, :private, :sort, :title)
  end
end
