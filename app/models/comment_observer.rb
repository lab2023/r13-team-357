class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    card = comment.card
    card.comment_count = card.comment_count + 1
    card.save!
  end

  def after_devise(comment)
    card = comment.card
    card.comment_count = card.comment_count - 1
    card.save!
  end
end
