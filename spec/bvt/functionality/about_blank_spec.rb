require 'spec_helper'

feature "blank page" do
  scenario "Testing General Blank Page" do
    HomePage.open
    HomePage.wait_for_opened
    BlankPage.open
    BlankPage.wait_for_opened
  end

end