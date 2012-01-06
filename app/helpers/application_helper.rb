module ApplicationHelper

  def get_current_user
    controller.get_current_user
  end

  def authenticated?
    not get_current_user.nil?
  end

  def form_errors(model)
    controller.render_to_string(:partial => 'layouts/errors', :locals => { :model => model }).html_safe
  end

  def timespamps(model)
    controller.render_to_string(:partial => 'layouts/timespamps', :locals => { :model => model }).html_safe
  end

  def application(path)
    sub_paths = path.split('/')
    node = Telasi.get_tree
    sub_paths.each do |p|
      node = node.children[p]
    end
    %Q{<div class="applink"><div style="background: url(/assets/#{node.image}) no-repeat 0 50%;">#{node_link(node)}</div></div>}.html_safe
  end

  def links_to(path)
    sub_paths = path.split('/')
    node = Telasi.get_tree
    text = "#{node_link(node)} "
    sub_paths.each do |p|
      node = node.children[p]
      text = "#{text} &gt; #{node_link(node)}"
    end
    %Q{<div id="top_links">#{text}</div>}.html_safe
  end

  private

  def node_link(node)
    %Q{<a href="#{node.path}">#{node.label}</a>}
  end

end
