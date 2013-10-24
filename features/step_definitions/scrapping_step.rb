require 'rake'
Dturno::Application.load_tasks

Given(/^I run the feeding task$/) do
  Rake::Task['gov_feed'].invoke
end

Then(/^I should find (\d+) excel download links$/) do |n|
  GovDoc.count.should eq n.to_i
end

Then(/^I should download the files$/) do
  doc = GovDoc.first.content
  doc.should_not be nil
  expect{File.open("/tmp/dturno_excel", 'wb'){|o| o.write doc }}.to_not raise_error
end