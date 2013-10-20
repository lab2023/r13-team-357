# encoding: UTF-8
class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  add_breadcrumb I18n.t('activerecord.models.documents'), :documents_path
  def index
    @search = Document.search(params[:q])
     @documents = @search.result(:distinct => true).paginate(:page => params[:page])
     respond_with(@documents)
  end

  def show
    add_breadcrumb @document.card, document_path(@document)
    respond_with(@document)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_document_path
    @document = Document.new
    respond_with(@document)
  end

  def edit
    add_breadcrumb @document.id, document_path(@document)
    add_breadcrumb t('tooltips.edit'), edit_document_path
  end

  def create
    @document = Document.create(file: params[:file], card_id: params[:document][:card_id], user_id: current_user.id)
    card = @document.card
    card.document_count = card.documents.count
    card.save
    render json: @document
    #respond_with(@document)
  end

  def update
    @document.update(document_params)
    respond_with(@document)
  end

  def destroy
    @document.destroy
    card = @document.card
    card.document_count = card.documents.count
    card.save
    respond_to do |format|
      format.html { redirect_to(card_path(@document.cart)) }
      format.js
      format.json{ render json: @document}
    end
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:card_id, :file)
  end
end
