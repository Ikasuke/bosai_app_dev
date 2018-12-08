require "open-uri"
require "openssl"

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

puts 'Start inserting seed "items"...'

5.times do |i|
  User.find_each do |user|
    puts "\"#{user.name}\" registed something!"
    url_pic = Faker::Avatar.unique.image(slug = nil, size = "300x300", format = "png")
    url_pic_en = URI.encode(url_pic)
    user.items.create({item_name: Faker::Food.fruits,
                       user_id: user.id,
                       category_id: 1,
                       item_expiry: Faker::Time.forward(1000, :morning),
                       picture: open(url_pic_en)})
  end
end
