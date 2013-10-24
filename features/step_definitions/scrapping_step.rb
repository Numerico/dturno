require 'rake'
Dturno::Application.load_tasks

Given(/^I run the feeding task$/) do
  Rake::Task['gov_feed'].invoke
end

Then(/^I should find (\d+) excel download links$/) do |n|
  GovDoc.count.should eq n.to_i
end
