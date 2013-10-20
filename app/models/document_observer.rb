class DocumentObserver < ActiveRecord::Observer
  def after_create(document)
    card = document.card
    card.document_count = card.document_count + 1
    card.save!
  end

  def after_destroy(document)
    card = document.card
    card.document_count = card.document_count - 1
    card.save
  end
end
