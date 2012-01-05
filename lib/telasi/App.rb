module App

  # პროგრამული ხის კვანძი.
  #
  class Node
    attr_accessor :name, :title, :parent, :children

    # ახალი კვანძის დამატება.
    def push(node)
      self.children = [] unless self.children
      self.children.push(node)
      self
    end

    def remove(node)
      # XXX:
    end
    
  end

end
