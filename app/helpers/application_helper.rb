module ApplicationHelper
  def display_status(is_pending)
    is_pending ? 'Pending' : 'Active'
  end
end
