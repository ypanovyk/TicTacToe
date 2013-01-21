require 'spec_helper'

describe "StaticPages" do

  let(:base_title){"Ruby on Rails Tutorial Sample App"}

  subject {page}

  shared_examples_for "all static pages" do
    it { should have_selector('h1', :text => heading) }
    it { should have_selector('title', :text => full_title(page_title)) }
  end

  describe "Home page" do

    before(:each) { visit root_path }

    let(:heading){'Sample App'}
    let(:page_title){''}

    it_should_behave_like "all static pages"
    it { should_not have_selector('title', :text=>"| Home") }
  end



  describe "Help page" do

    before(:each) { visit help_path }

    let(:heading){'Help'}
    let(:page_title){'Help'}

    it_should_behave_like "all static pages"
  end

  describe "About page" do

    before(:each) { visit about_path }

    let(:heading){'About Us'}
    let(:page_title){'About Us'}

    it_should_behave_like "all static pages"
  end
    
  describe "Contact" do

    before(:each) { visit contact_path }

    let(:heading){'Contact'}
    let(:page_title){'Contact'}

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
   click_link "sample app"
   should have_selector('h1', text:"Sample App")
   click_link "Sign in"
   should have_selector('h1', text:"Sign up")
   click_link "Help"
   should have_selector('h1', text:"Help")
   click_link "Home"
   should have_selector('h1', text:"Sample App")
   click_link "About"
   should have_selector('h1', text:"About")
   click_link "Contact"
   should have_selector('h1', text:"Contact")
   click_link "Home"
   click_link "Sign up now!"
   should have_selector('h1', text:"Sign up")
  end
end                     

