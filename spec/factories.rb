FactoryGirl.define do
  factory :user do
    name "Michael Hartl"
    email "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :participant, class: User  do
    name "Harry Potter"
    email "hpotter@example.com"
    password "hpotter"
    password_confirmation "hpotter"

  end

  factory :game do
    creator {User.first.id}
    participant nil 
    status "new"
    winner nil
    whose_turn 1
  end
end
