
FactoryGirl.define do
  factory :user do
    user_name {Faker::Internet.user_name}
    password "ABCDEF"


    factory :jerry do
      user_name 'jerry'
    end

  end
end
