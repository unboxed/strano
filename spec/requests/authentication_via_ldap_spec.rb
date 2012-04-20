require 'spec_helper'

feature "Signing in via LDAP" do
  
  let(:user) { FactoryGirl.create(:user) }
  
  background do
    visit root_path
  end

  scenario "Signing in with correct credentials" do
    
    within("#session") do
      puts page.body
      fill_in 'username', :with => 'user@example.com'
      fill_in 'password', :with => 'caplin'
      click_button 'Sign in via LDAP'
    end
    
    current_path.should == projects_path
    
    within '#user_display_bar' do
      page.should have_content(user.username)
    end
  end
  
  scenario "Trying to sign in with invalid credentials" do
    within("#session") do
      fill_in :username, :with => 'user@example.com'
      fill_in :password, :with => 'caplin'
      click_button 'Sign in via LDAP'
    end
    
    current_path.should == root_path
    page.should have_content 'Invalid username or password.'
  end
  
end
