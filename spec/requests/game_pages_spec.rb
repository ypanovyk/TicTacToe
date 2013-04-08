require 'spec_helper'
include UsersHelper

describe "GamePages:" do
  subject {page}

  after(:all){ User.delete_all }

  describe "Games list page" do
    let(:user) {FactoryGirl.create(:user)}
    let(:game){FactoryGirl.create(:game)}
    let(:participant) {FactoryGirl.create(:participant)}

    context "not signed in user" do
      before {visit games_path}

      it { should have_selector('h1', text: 'Sign in')}
    end
    
    context "when user is signed in" do
      before do
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

      describe "pagination" do
        before(:all) do
          FactoryGirl.create(:user)
          30.times { FactoryGirl.create(:game) }
        end
        after(:all) { Game.delete_all }

        it { should have_selector('div.pagination')}

        it "should list each game" do
          Game.paginate(page:1).each do |game|
            page.should have_selector('td', text: "#{game.id}")
          end
        end
      end
      
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
          it {should have_selector(:xpath, "//tr/td[6]/a[@href='/games/#{game.id}/join']")}
        end
      end

      #TODO add tests for Game details page

    end
  end
end
