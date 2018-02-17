User.create!(username:  "Example User",
             email: "example@example.net",
             password: "password",
             password_confirmation: "password")
             
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  User.create!(username:  name,
               email: email)
end

(1..3).each do |n|
  (4..6).each do |m|
    relationship = User.find(n).received_requests.create!(requester_id: m)
    relationship.toggle!(:confirmed_friends) unless m == 5
  end
end

(1..3).each do |n|
  (7..9).each do |m|
    relationship = User.find(n).sent_requests.create!(receiver_id: m)
    relationship.toggle!(:confirmed_friends) unless m == 8
  end
end

users = User.order(:created_at).take(9)
50.times do |n|
  content = Faker::Lorem.sentence(5)
  comment = Faker::Lorem.sentence
  users.each do |user|
    post = user.posts.create!(content: content)
    if n % 3 == 0
      user.comments.create!(content: comment, 
                            commentable_id: post.id,
                            commentable_type: "Post")
    end
  end
end