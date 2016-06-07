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

class Goal < ActiveRecord::Base
  validates :title, :completed, :public, :details, :user_id, presence: true
end
