class SourceText < String

 COLUMN_TYPE = :text

 HoboFields.register_type(:sourcetext, self)

 def validate
   "is too long (you shouldn't add so many sources)" if length > 500
 end

# def format
#   # make sure we have enough exclamation marks
#   self =~ /!!!$/ ? self + "!!!" : self
# end

 def to_html(xmldoctype = true)
   a = self
   Sfilter.select{ |sf| a.match(/https?:\/\/(#{sf.filter}[^\/]*)[^\s]*/) }.
           each{ |f|  a.gsub!(/(https?:\/\/#{f.filter}[^\/]*[^\s]*)/,'<a href="\1" target="_blank">'+f.name+'</a>') }
   a.html_safe
 end

end
