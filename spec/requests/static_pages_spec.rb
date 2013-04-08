require 'spec_helper'

describe "StaticPages" do

  subject {page}

  shared_examples_for "all static pages" do
    it { should have_selector('h1', :text => heading) }
    it { should have_selector('title', :text => full_title(page_title)) }
  end

  describe "Home page" do

    before(:each) { visit root_path }

    let(:heading){'Tic Tac Toe'}
    let(:page_title){''}

    it { should have_selector('h4', :text => heading) }
    it { should have_selector('title', :text => full_title(page_title)) }
    it { should_not have_selector('title', :text=>"| Home") }
  end

  describe "Contact" do

    before(:each) { visit contact_path }

    let(:heading){'Contact'}
    let(:page_title){'Contact'}

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
   click_link "tic tac toe"
   should have_selector('h4', text:"Tic Tac Toe")
   click_link "Sign in"
   should have_selector('h1', text:"Sign in")
   click_link "Home"
   should have_selector('h4', text:"Tic Tac Toe")
   click_link "Contact"
   should have_selector('h1', text:"Contact")
   click_link "Home"
   click_link "Sign up now!"
   should have_selector('h1', text:"Sign up")
  end

  describe "Sign up" do
    before { visit signup_path}

    let(:submit){"Create my account"}

    it {should have_selector('h1', text:'Sign up')}
    it { should have_selector('title', text:full_title('Sign up'))}
    
    describe "with invalid user data" do
      it "should not create a user" do
        expect {click_button submit }.not_to change(User, :count)
      end 

      context "after submission" do
        before {click_button submit}

        it {should have_selector('div', id:"error_explanation")}
        it {should have_content "The form contains 6 errors."}
      end
    end

    describe "with valid user data" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirm password", with: "foobar"
        select('English', :from => 'Language')
      end

      it "should create a user" do
        expect {click_button submit }.to change(User, :count).by(1)
      end 

      context "after submission" do
        before {click_button submit}
        let(:user){User.find_by_email("user@example.com")}
        
        it {should have_selector('title', text: user.name)}
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it {should have_link('Sign out')}
      end
    end
  end
end                     

