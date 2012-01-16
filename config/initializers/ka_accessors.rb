# encoding: utf-8

# adding KA handlers for selected fields
class Class

  GEO = 'ÀÁÂÃÄÅÆÈÉÊËÌÍÏÐÑÒÓÔÖ×ØÙÚÛÜÝÞßàáãä'
  KA = 'აბგდევზთიკლმნოპჟრსტუფქღყშჩცძწჭხჯჰ'

  def self.convert_text(text, from, to)
    if text
      txt = ""
      text.split('').each do |c|
        indx = from.index(c)
        if indx
          txt += to[indx]
        else
          txt += c
        end
      end
    end
    txt
  end

  def self.to_ka(text)
    Class.convert_text(text, GEO, KA)
  end

  def self.to_geo(text)
    Class.convert_text(text, KA, GEO)
  end

  def ka_accessor(*my_accessors)
    my_accessors.each do |accessor|
      define_method("#{accessor}_ka") do
        Class.to_ka( send("#{accessor}") )
      end
      define_method("#{accessor}_ka=") do |accessor_value|
        send( "#{accessor}=", Class.to_geo( accessor_value ) )
      end
    end

  end

end
