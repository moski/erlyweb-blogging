require 'net/http'
require 'rubygems'
require 'hpricot'
require 'erlectricity'
require 'uv'

def check_for_parsing_and_parse(str)
  doc = Hpricot(str)
  doc.search("code").each  do |element|
    lang  = element.attributes['lang'] || "ruby"
    theme = element.attributes['theme'] || "twilight"
    if element.attributes['line_numbers'] &&  element.attributes['line_numbers'] == "false"
        line_numbers = false
    else
        line_numbers = true
    end
    new_str = Uv.parse(element.inner_html, "xhtml", lang , line_numbers, theme)
    element.inner_html = new_str
  end
  doc.to_html
end

receive do |f|
  f.when(:echo, String) do |text|
    f.send!(:result, "You said #{text}")
    f.receive_loop
  end
  f.when(:textmate, String) do |text|
    string = check_for_parsing_and_parse(text)
    f.send!(:result, string)
    f.receive_loop
  end
end