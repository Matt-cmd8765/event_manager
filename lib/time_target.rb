require 'csv'
require 'date'
require 'time'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

def max_peeps(array)
  tally = array.tally
  group = tally.group_by{|k,v| v}
  maxim = group.max_by{|k,v| k}
  get_rid_of_key = maxim.pop
  get_rid_of_key.map! do |cut|
    cut.shift
  end
  get_rid_of_key.each do |hour|
    puts "#{hour}:00"
  end
end

def max_days(array)
  tally = array.tally
  group = tally.group_by{|k,v| v}
  maxim = group.max_by{|k,v| k}
  get_rid_of_key = maxim.pop
  get_rid_of_key.map! do |cut|
    cut.shift
  end
end

def weekdays(day)
  case day
  when 0
    'Sunday'
  when 1 
    'Monday'
  when 2
    'Tuesday'
  when 3
    'Wednesday'
  when 4
    'Thursday'
  when 5
    'Friday'
  when 6
    'Saturday'
  end
end

hours = []
days = []

contents.each do |row|
  date = row[:regdate]
  help = Time.strptime(date, "%D %H")
  hours << help.hour
  days << help
end

days.map! do |day|
  weekdays(day.wday)
end

puts "Max users at these day(s):"
puts max_days(days)
puts 'and these time(s):'
max_peeps(hours)