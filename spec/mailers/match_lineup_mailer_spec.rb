require "spec_helper"

describe MatchLineupMailer do
  before :each do
    user = create(:user)
    user2 = create(:user2)
    @team = create(:team, :users => [user, user2])
    ActsAsTenant.current_tenant = @team
    @match = create(:match)
    @match.match_lineups.each do |lineup|
      lineup.match_players.create(:user => user)
    end
  end

  after :each do
    ActsAsTenant.current_tenant = nil
  end

  it 'sends match lineup set email' do
    email = MatchLineupMailer.lineup_set(@team.id, @match.id).deliver

    last_email.should_not be_nil
    email.to.should =~ ['team-email@mail.breakpointapp.com']
    email.subject.should match /\[#{@match.team.name}\] Lineup set for match on/
    email.encoded.should match /<h1>The lineup has been set/
  end

  it 'sends match lineup updated email', :versioning => true do
    email = MatchLineupMailer.lineup_updated(@team.id, @match.id, @match.recent_changes).deliver

    last_email.should_not be_nil
    email.to.should =~ ['team-email@mail.breakpointapp.com']
    email.subject.should match /\[#{@match.team.name}\] Lineup updated for match on/
    email.encoded.should match /<h1>The lineup was updated for/
  end
end

