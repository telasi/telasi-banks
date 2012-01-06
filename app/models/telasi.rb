# encoding: utf-8
module Telasi

  private

  SYS = 'sys'
  BANKS = 'banks'

  public

  HOME_PATH = ""
  SYS_PATH = "#{SYS}"
  BANKS_PATH = "#{SYS_PATH}/#{BANKS}"

  class App
    attr_accessor :name, :label, :url, :parent, :children, :image
    def path
      if parent
        "#{parent.path}#{self.url}"
      else
        self.url
      end
    end
  end

  def Telasi.get_tree
    @@app_tree = build_app_tree unless defined?(@@app_tree)
    @@app_tree
  end

  private

  def Telasi.build_app_tree
    build_node(nil, '', APPLICATION_TREE)
  end

  def Telasi.build_node(parent, name, hash)
    node = App.new
    node.parent = parent
    node.name = name
    node.label = hash[:label]
    node.url = hash[:url]
    node.image = hash[:image]
    node.children = {}
    (hash[:children] || {}).each do |key, value|
      node.children[key.to_s] = build_node(node, key.to_s, value)
    end
    node
  end

  APPLICATION_TREE = {
    :url => '/',
    :label => 'საწყისი',
    :children => {
      SYS => {
        :url => 'sys/',
        :label => 'ადმინისტრირება',
        :image => 'admin.png',
        :children => {
          BANKS => {
            :url => 'banks/',
            :label => 'ბანკები',
            :image => 'banks.png'
          },
        },
      },
    },
  }

end
