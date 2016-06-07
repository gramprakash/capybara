# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  public     :boolean          not null
#  completed  :boolean          not null
#  user_id    :integer          not null
#  details    :string           not null
#  cheers     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    title { Faker::Hipster.sentence(4) }
    public {[true,false].sample}
    completed {[true,false].sample}
    user_id {User.all.sample.id}
    details { Faker::Hipster.paragraph(2) }
    cheers 1
  end
end
