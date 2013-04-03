FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "Person #{n}"}
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :participant, class: User  do
    name "Harry Potter"
    email "hpotter@example.com"
    password "hpotter"
    password_confirmation "hpotter"

  end

  factory :game do
    #creator { |id| id.association(:user).id}
    creator {User.first.id}
    participant nil 
    status "new"
    winner nil
    whose_turn 1
  end
end
