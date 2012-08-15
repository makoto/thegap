require 'pp'
require 'time'
require 'json'
rows = File.readlines('./data.txt')

def convert_sec(string)
  delimiters = string.match(':') && string.split(':').size  
 case delimiters
  when 3 then
    hour, min, sec = string.split(':').map &:to_f
    (((hour * 60) + min) * 60) + sec
  when 2 then
    min, sec = string.split(':').map &:to_f
    ( min * 60) + sec
  when nil then
    string.to_f
  else
    raise 'omg2'
  end
end


puts JSON.generate rows.map{|r|
  category, event, second, first = r.chomp!.split('|')
  # p ['1', category, event, second, first]
  raise 'omg1' if (first.match(':') && first.match(':').size) != (second.match(':') && second.match(':').size)
  
  delimiters = first.match(':') && first.split(':').size

  first_sec = convert_sec first
  second_sec = convert_sec second
  diff = second_sec - first_sec
  ratio = diff / first_sec
  # pp [category, event, second, first, diff]
  {
    category:category,
    event:event,
    first:first,
    first_sec: first_sec,
    second:second,
    second_sec: second_sec,
    diff:diff,
    ratio: ratio
  }  
}.sort_by{|a| a[:diff]}