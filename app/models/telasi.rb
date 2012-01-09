# encoding: utf-8
module Telasi

  CUSTOMERS_TABLE = 'customer'

  private

  SYS = 'sys'
  BANKS = 'banks'
  USERS = 'users'
  BANK_HOME = 'bank-{{bank_id}}'
  BANK_CUST = 'cust'

  CLASS_MAPPING = {
    'bank' => Bank
  }

  public

  # საწყისი
  HOME_PATH = ""
  # სისტემული
  SYS_PATH = "#{SYS}"
  SYS_BANKS_PATH = "#{SYS_PATH}/#{BANKS}"
  SYS_USERS_PATH = "#{SYS_PATH}/#{USERS}"
  # ბანკის სერვისები
  BANK_HOME_PATH = "#{BANK_HOME}"
  BANK_CUST_PATH = "#{BANK_HOME_PATH}/#{BANK_CUST}"

  class Node
    attr_writer :label, :url
    attr_accessor :name, :parent, :children, :image, :dynamic

    # ობიექტის პოვნა ამ კვანძისთვის
    def get_object(params = {})
      unless @__object
        id = obj_id(params)
        @__object = CLASS_MAPPING[self.dynamic].find(id) if id
      end
      @__object
    end

    # კვანძის მისამართის პოვნა
    def path(params = {})
      if parent
        "#{parent.path(params)}#{self.url(params)}"
      else
        self.url(params)
      end
    end

    # წარწერა ამ კვანძისთვის
    def label(params = {})
      if self.dynamic
        get_object(params).to_s
      else
        @label
      end
    end

    def url(params = {})
      if self.dynamic
        id = obj_id(params)
        "#{self.dynamic}-#{id}/"
      else
        @url
      end
    end
    
    def find_child(name)
      split = name.split('-')
      self.children[name]
    end

    private

    def obj_id(params)
      params["#{self.dynamic}_id"]
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
    node = Node.new
    node.parent = parent
    node.name = name
    node.label = hash[:label]
    node.url = hash[:url]
    node.image = hash[:image]
    node.dynamic = hash[:dynamic]
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
          USERS => {
            :url => 'users/',
            :label => 'მომხმარებლები',
            :image => 'users.png'
          }
        },
      },
      BANK_HOME => {
        :dynamic => 'bank',
        :image => 'bank.png',
        :children => {
          BANK_CUST => {
            :url => 'cust/',
            :label => 'აბონენტები',
            :image => 'bank_cust.png'
          }
        }
      }
    },
  }

end
