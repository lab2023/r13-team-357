class ChecklistObserver < ActiveRecord::Observer
  def after_create(checklist)
    card = checklist.card
    card.checklist_total_count = card.checklist_total_count + 1
    card.save!

  end

  def after_update(checklist)
    card = checklist.card
    card.checklist_done_count = card.checklist_done_count + 1 if checklist.done?
    card.save!
  end
end
