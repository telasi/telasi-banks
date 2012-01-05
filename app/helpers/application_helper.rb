module ApplicationHelper

  def form_errors(model)
    controller.render_to_string(:partial => 'layouts/errors', :locals => { :model => model }).html_safe
  end

  def get_current_user
    controller.get_current_user
  end
  
end
