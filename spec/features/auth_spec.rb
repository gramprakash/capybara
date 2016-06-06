# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit '/users/new'
    expect(page).to have_content('Sign Up')
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      sign_up_jasmine
      expect(page).to have_content('Jasmine')
    end
  end

end

feature "logging in" do
  before(:each) { FactoryGirl.build(:jerry) }

  it "shows username on the homepage after login" do
    sign_in_jerry

    expect(page).to have_content('jerry')
  end

end

feature "logging out" do
  before(:each) do
    FactoryGirl.build(:jerry)
    sign_in_jerry
  end

  # it "begins with logged out state"
  it "begins with logged in state" do
    expect(page).to have_content('jerry')
  end

  it "doesn't show username on the homepage after logout" do
    click_button('Log Out')
    expect(page).to have_content('Sign In')
  end

end
