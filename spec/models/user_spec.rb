# == Schema Information
#
# Table name: users
#
#  id                         :integer(4)      not null, primary key
#  username                   :string(255)
#  github_access_token        :string(255)
#  github_data                :text
#  ssh_key_uploaded_to_github :boolean(1)      default(FALSE)
#  created_at                 :datetime        not null
#  updated_at                 :datetime        not null
#  deleted_at                 :datetime
#  token                      :string(255)
#

require 'spec_helper'

describe User do

  describe "upload Strano SSH key to users Github account after creation" do
    use_vcr_cassette 'Github_Key/_create', :erb => true
    
    it "should upload SSH key to Github" do
      user = FactoryGirl.create(:user)
      user.ssh_key_uploaded_to_github?.should == true
    end
  end
  
  describe "#authorized_for_github?" do
    before(:each) { User.disable_ssh_github_upload = true }
    
    it { FactoryGirl.build(:user, :github_access_token => nil).authorized_for_github?.should == false }
    it { FactoryGirl.create(:user).authorized_for_github?.should == true }
  end

  describe "#github" do
    before(:each) { User.disable_ssh_github_upload = true }
    
    it { FactoryGirl.build(:user, :github_access_token => nil).github.should be_nil }
    it { FactoryGirl.create(:user).github.should be_a(Github) }
  end

end
