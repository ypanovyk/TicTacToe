require 'spec_helper'

describe "StaticPages" do

  let(:base_title){"Ruby on Rails Tutorial Sample App"}

  subject {page}

  describe "Home page" do

    before(:each) do
      visit root_path
    end

      it { should have_selector('h1', :text => 'Sample App') }

      it { should have_selector('title', :text => "#{base_title}") }

      it { should_not have_selector('title', :text=>"| Home") }
  end

  
  
  describe "Help page" do

    before(:each) do
      visit help_path
    end

      it { should have_selector('h1', :text => 'Help') }

      it { should have_selector('title', :text => "#{base_title} | Help") }
  end

  describe "About page" do

    before(:each) do
      visit about_path
    end

      it { should have_selector('h1', :text => 'About Us') }

      it { should have_selector('title', :text => "#{base_title} | About Us") }
  end

  describe "Contact" do

    before(:each) do
      visit contact_path
    end

      it { should have_selector('h1', :text => 'Contact') }

      it { should have_selector('title', :text => "#{base_title} | Contact") }
  end
end                     

