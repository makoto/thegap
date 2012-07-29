require 'pp'
require 'time'
require 'json'
rows = File.readlines('./data.txt')
puts JSON.generate rows.map{|r|
  category, event, second, first = r.chomp!.split('|')
  # p ['1', category, event, second, first]
  raise 'omg1' if (first.match(':') && first.match(':').size) != (second.match(':') && second.match(':').size)
  
  delimiters = first.match(':') && first.split(':').size
  diff = case delimiters
  when 3 then
    Time.parse(second) - Time.parse(first)
  when 2 then
    Time.parse("0:#{second}") - Time.parse("0:#{first}")
  when nil then
    second.to_f - first.to_f
  else
    raise 'omg2'
  end
  # pp [category, event, second, first, diff]
  {
    category:category,
    event:event,
    first:first,
    second:second,
    diff:diff
  }  
}.sort_by{|a| a[:diff]}