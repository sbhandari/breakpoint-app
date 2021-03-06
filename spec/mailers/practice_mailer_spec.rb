require "spec_helper"

describe PracticeMailer do
  before :each do
    user = create(:user)
    user2 = create(:user2)
    @team = create(:team, :users => [user, user2]) 
    ActsAsTenant.current_tenant = @team
    @practice = create(:practice)
  end

  after :each do
    ActsAsTenant.current_tenant = nil
  end

  it 'sends practice scheduled email' do
    email = PracticeMailer.practice_scheduled(@team.id, @practice.id).deliver
    
    last_email.should_not be_nil
    email.to.should =~ ['team-email@mail.breakpointapp.com']
    email.subject.should eq "[#{@practice.team.name}] New practice scheduled"
    email.encoded.should match /<h1>New practice scheduled for/
  end

  it 'sends practice updated email', :versioning => true do
    email = PracticeMailer.practice_updated(@team.id, @practice.id, @practice.recent_changes).deliver

    last_email.should_not be_nil
    email.to.should =~ ['team-email@mail.breakpointapp.com']
    email.subject.should eq "[#{@practice.team.name}] Practice updated"
    email.encoded.should match /<h1>Practice scheduled for/
  end
end

