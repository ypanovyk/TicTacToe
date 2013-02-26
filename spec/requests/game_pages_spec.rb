require 'spec_helper'
include UsersHelper

describe "GamePages" do
  subject {page}

  describe "games list page" do
    let(:user) {FactoryGirl.create(:user)}
    let(:game){FactoryGirl.create(:game)}
    let(:participant) {FactoryGirl.create(:participant)}

    before do
      visit signin_path
      login_as(user)

      visit user_path(user)
      visit game_path(game)
      visit games_path
    end

    it {User.count.should == 1}
    it {Game.count.should ==1}
    it {should have_selector('table', class:"games-table")}
    it {should have_selector(:xpath, "//tr/td[1][text()=#{game.id}]")}
    it {should have_selector(:xpath, "//tr/td[2][text()='#{username(game.creator)}']")}
    it {should have_selector(:xpath, "//tr/td[3][text()='--']")}
    it {should have_selector(:xpath, "//tr/td[4][text()='#{game.status}']")}
    it {should have_selector(:xpath, "//tr/td[5][text()='--']")}
    it {should_not have_selector(:xpath, "//tr/td[6]/a[@href='/games/#{game.id}']")}

    context "participant joined the game" do
      before do
        game.participant=participant.id
        game.status="active"
        game.save
        visit games_path
      end
      it {should have_selector(:xpath, "//tr/td[3][text()='#{username(game.participant)}']")}
      it {should have_selector(:xpath, "//tr/td[4][text()='#{game.status}']")}
      it {should_not have_selector(:xpath, "//tr/td[6]/a[@href='/games/#{game.id}']")}

    end

    context "game closed" do
      before do
        game.status="closed"
        game.save
        visit games_path
      end
      it {should have_selector('tr', class:"closed")}
      it {should have_selector(:xpath, "//tr[@class='closed']/td[4][text()='#{game.status}']")}
      it {should_not have_selector(:xpath, "//tr[@class='closed']/td[6]/a[@href='/games/#{game.id}']")}

    end
    
    describe "join game button" do
      context "logged in as participant" do
        before do
          visit signin_path
          login_as(participant)
          visit games_path
        end
        it {should_not have_selector(:xpath, "//tr[@class='closed']/td[6]/a[@href='/games/#{game.id}']")}
      end
    end
  end
end
