require 'csv'
puts "Gettin' them digits boss!"

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

def clean_number(number)
  # If the phone number is less than 10 digits, assume that it is a bad number
  # If the phone number is more than 11 digits, assume that it is a bad number
  number.gsub!(/[[:punct:]]/, '')
  number.gsub!(' ','')
  if number.length < 10 || number.length > 11
    'not a valid phone number!'
  #  If the phone number is 10 digits, assume that it is good
  elsif number.length == 10
    number
  # If the phone number is 11 digits and the first number is 1, trim the 1 and use the remaining 10 digits
  elsif number.length == 11 && number[0] == '1'
    number.slice!(1, 11)
  # If the phone number is 11 digits and the first number is not 1, then it is a bad number
  elsif number.length == 11 && number[0] != 1
    'not a valid phone number!'
  end
end

contents.each do |row|
  name = row[:first_name]
  number = row[:homephone]
  clean_num = clean_number(number)
  puts "#{name}'s number is #{clean_num}"
end