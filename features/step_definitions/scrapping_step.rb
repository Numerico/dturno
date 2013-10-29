require 'rake'
Dturno::Application.load_tasks

Given(/^I run the feeding task$/) do
  Rake::Task['gov_feed'].invoke
end

Then(/^I should find (\d+) excel download links$/) do |n|
  GovDoc.count.should eq n.to_i
end

Then(/^I should download the files$/) do
  @doc = GovDoc.first.content
  @doc.should_not be nil
  @tmp = "/tmp/dturno_excel.xlsx"
  expect{File.open(@tmp, 'wb'){|output| output.write @doc }}.to_not raise_error
end

Then(/^I should parse the files to ruby$/) do
  @excel = SimpleXlsxReader.open @tmp
  @excel.should_not be nil
end

Then(/^I should have more than (\d+) drugstores$/) do |n|
  data = @excel.sheets.first.data
  data.should_not be nil
  DrugStore.count.should > n.to_i
end

Then(/^I should end up with (\d+) "(.*?)"$/) do |n, type|
  eval(type).count.should > n.to_i
end
