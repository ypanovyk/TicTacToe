require "spec_helper"

describe ApplicationHelper do
  it "shold include the page title" do
    full_title("foo").should =~/foo/
  end  

  it "should include the base title" do
    full_title('foo').should =~/^Tic Tac Toe/
  end

  it "should not include a br for the home page" do
    full_title('').should_not =~/\|/
  end
end
