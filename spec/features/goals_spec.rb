# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature 'redirect to user page after login' do
  it "shows user page after login" do
    # visit session/new
    # login
    # expect(page).to have_content(username's Profile)
    #
  end

end

feature 'Create a goal' do

  before(:all) { sign_up_jasmine }
  before(:each) do
    FactoryGirl.create(:jerry)
    click_create_goal
  end

  it 'should be to go to create goal page from their show page' do
    expect(page).to have_content('New Goal')
  end

  it 'should validates for title' do
    click_button('New Goal')
    expect(page).to have_content('Title can\'t be blank')
    fill_in 'title', with: 'e'
    expect(page).to have_content('Title is too short')
    #factory girl without a tiltle

    #expect page to have content 'Title can't be blank'
    #expect page to have content 'Title is too short'
  end

  it 'should redirect to goal show page on successful save.' do
    goal_create_success

    expect(page).to have_content('Goal:')
    #click_button 'New Goal'
    # expect page to have content 'Goal:'
  end

  it 'should show all the correct data' do
    goal_create_success
    expect(page).to have_content('Eat Donuts!', 'EAT!', 'Public', 'Did not complete?')
  end
end

feature 'mark a goal completed' do
  let(:jerry) { FactoryGirl.create(:user_jerry) }
  let(:jerry_goal) { FactoryGirl.create(:goal, user_id: jerry) }
  before (:each) { sign_in_jerry }

  # before(:each) {)}
  it 'should mark a goal as completed' do
    jerry_goal.update(completed: false)
    click_button("complete")
    expect(page).to have_button("not complete")
  end

  it 'should be able to undo a goal that is mistakenly completed' do
    jerry_goal.update(completed: true)
    click_button("not complete.")
    expect(page).to have_button("complete")
  end

  it 'should have a link to the user page' do
    expect(page).to have_content('Profile')
  end
end

feature 'users show page' do
  let(:jerry) { FactoryGirl.create(:user_jerry) }
  let(:jerry_goal) { FactoryGirl.create(:goal, user_id: jerry) }
  before (:each) { sign_in_jerry }

  it 'should display all of their goals' do
    goal1 = FactoryGirl.create(:goal, user: jerry)
    goal2 = FactoryGirl.create(:goal, user: jerry)
    goal3 = FactoryGirl.create(:goal, user: jerry)

    visit "users/#{jerry.id}"
    expect(page).to have_content(goal1.title)
    expect(page).to have_content(goal2.title)
    expect(page).to have_content(goal3.title)
  end

  it 'should be able to complete a goal from the show page' do
    click_button "complete"
    expect(page).to have_button("not complete")
  end

  it 'should be able to undo a goal that is mistakenly completed' do
    jerry_goal.update(complete: true)
    visit "users/#{jerry.id}"
    click_button("not complete")
    expect(page).to have_button("complete")
  end

  it 'should have able to delete a goal' do
    click_button("delete")
    expect(page).to_not have_content(jerry_goal.title)
  end

  it 'should be able to see the status of a goal' do
    jerry_goal.update(complete: true)
    visit "users/#{jerry.id}"
    expect(page).to have_content("completed")

    jerry_goal.update(complete: false)
    visit "users/#{jerry.id}"
    expect(page).to have_content("ongoing")
  end

  it 'should not allow other users to modify a goal' do
    click_button("Log Out")
    sign_up_jasmine
    visit "users/#{jerry.id}"
    expect(page).to_not have_button("complete")
    expect(page).to_not have_button("delete")
  end

end
