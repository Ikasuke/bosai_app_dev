require "open-uri"
require "openssl"

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

puts 'Start inserting seed "users"...'

10.times do
  url_avatar = Faker::Avatar.unique.image(slug = nil, size = "300x300", format = "png")
  url_avatar_en = URI.encode(url_avatar)
  user = User.create({
    name: Faker::Internet.unique.user_name,
    email: Faker::Internet.unique.email,
    public_name: Faker::Name.unique.name,
    encrypted_password: Faker::Internet.password(8),
    avatar: open(url_avatar_en),
  })

  puts "\"#{user.name}\" has created!"

  user.confirm
end
