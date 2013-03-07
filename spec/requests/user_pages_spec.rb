require 'spec_helper'

describe "UserPages:" do
  subject {page}
  let(:user) {FactoryGirl.create(:user)}

  describe "index page" do
    context "when user is logged in" do
      before(:each) do
        login_as user
        visit users_path
      end

      it {should have_selector('h1', text: 'All users')}
      it {should have_selector('title', text: 'All users')}

      describe "pagination" do
        before(:all) { 30.times { FactoryGirl.create(:user) } }
        after(:all) { User.delete_all }

        it { should have_selector('div.pagination')}

        it "should list each user" do
          User.paginate(page:1).each do |user|
            page.should have_selector('li', text: user.name)
          end
        end

      end

    end
  end
  
  describe "profile page" do
    before {visit user_path(user)}

    it {should have_selector('h1', text: user.name)}
    it {should have_selector('title', text: user.name)}

    context "when user is logged in" do
      before do
        login_as user
        visit user_path(user)
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

  describe "edit page" do
    context "when user is logged in" do
      before do
        login_as(user)
        visit edit_user_path(user)
      end
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }

      context "with invalid information" do
        before { click_button "Save changes" }

        it { should have_content('error') }
      end

      context "with valid information" do
        let(:new_name) {"New Name"}
        let(:new_email){"new@example.com"}

        before do
          fill_in "Name", with: new_name
          fill_in "Email", with: new_email
          fill_in "Password", with: user.password
          fill_in "Confirm Password", with: user.password
          click_button "Save changes"
        end

        it { should have_selector('title', text: new_name) }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign out', href: signout_path) }
        specify { user.reload.name.should  == new_name }
        specify { user.reload.email.should == new_email }
      end
    end
  end
end
