# encoding: UTF-8
class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  add_breadcrumb I18n.t('activerecord.models.comments'), :comments_path
  def index
    @search = Comment.search(params[:q])
     @comments = @search.result(:distinct => true).paginate(:page => params[:page])
     respond_with(@comments)
  end

  def edit
    add_breadcrumb @comment.id, comment_path(@comment)
    add_breadcrumb t('tooltips.edit'), edit_comment_path
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment_id = @comment.id
    @comment.destroy if @comment.user == current_user

    respond_to do |format|
      format.js
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :card_id)
  end
end
