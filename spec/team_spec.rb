require 'spec_helper'

describe Team do
  it "has a name" do
    Team.new("Random Name").should respond_to :name
  end

  it "has a list of players" do
    Team.new("Random Name").players.should be_kind_of Array
  end

  it "is favored if it has a celebrity in it" do
    Team.new("team", ["Ricky", "Jaejun Yu"])
  end

  it "complains if there is a bad word in the name" do
    expect {
      Team.new("Crappy Name")
    }.to raise_error
  end

  context "given a bad list of players" do
    let(:bad_players) { {} }

    it "fails to create given a bad player list" do
      expect {
        Team.new("Random name", bad_players)
      }.to raise_error
    end
  end

end
