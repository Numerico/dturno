Given(/^I browse to the (.*?) page$/) do |path|
  visit send "#{path}_path"
end

Then(/^I should see a (.*?) that says "(.*?)"$/) do |tag, content|
  page.should have_selector tag
  find(tag).should have_content content
end