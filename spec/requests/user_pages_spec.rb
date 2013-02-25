require 'spec_helper'

describe "UserPages" do
  subject {page}

  describe "profile page" do
    let(:user) {FactoryGirl.create(:user)}
    before {visit user_path(user)}
    it {should have_selector('h1', text: user.name)}
    it {should have_selector('title', text: user.name)}

    context "when user is logged in" do
      before do
        visit signin_path
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end


      it {should have_link('New game', href: new_game_path)}
      it {should have_link('Join game', href: games_path)}

      context "New game button" do

        it "should create new game"  do
          expect {click_link "New game"}.to change(Game, :count).by(1)
        end

        context "after click" do
          before {click_link "New game"}
          it {should have_selector('div', class:'board')}
        end
      end
    end
  end
end
