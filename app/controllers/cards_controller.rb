# encoding: UTF-8
class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def show
    add_breadcrumb @card.list.project.name, project_path(@card.list.project)
    add_breadcrumb "Card ##{@card.id}", card_path(@card)
    @collaborators = @card.list.project.users
    @checklist_percentage = 100 * @card.try(:checklist_done_count).to_i / @card.try(:checklist_total_count).to_i
    respond_with(@card)
  end


  def create
    @card = Card.new(card_params)
    @card.owner_id = current_user.id
    @card.save
    respond_to do |format|
      format.js
    end
  end

  def update
    @card.update(card_params)
    respond_to do |format|
      format.html { redirect_to(card_path(@card)) }
      format.js
      format.json{ render json: @card}
    end
  end

  def destroy
    @card_id = @card.id
    @card.destroy
    respond_to do |format|
      format.js
    end
  end

  def move
    @current_list = List.find(params[:list])
    @current_card = Card.find(params[:id])
    @current_card.sort = 0
    @current_card.list = @current_list
    @current_card.save
    @cards = @current_list.cards
    sort = Array.new
    params[:sort].each do |hash|
      sort << hash.to_i
    end
    @cards.each_with_index do |card,index|
      card.sort = index*100
      card.save
    end

    @cards.each do |card|
      card.sort = (sort.index(card.id))+1
      card.save
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def set_card
    @card = @current_project.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:assignment_id, :body, :done, :due_date, :list_id, :private, :sort, :title)
  end
end
