# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

  r = Random.new
  r.rand(4..20).times{
    a = Article.create!(
        :title => Lorem::Base.new('words', r.rand(1..10)).output,
        :content => Lorem::Base.new('paragraphs', r.rand(1..5)).output,
        :category => Article::CATEGORY.sample,
        :rating => r.rand(1..20),
        :url => 'www.FlatBlog3.com',
        :tags => Article::CATEGORY.sample)

    r.rand(1..5).times {
      a.comments.create!(
        :author => Lorem::Base.new('paragraphs', 1).output.scan(/\w+/).sample,
        :content => Lorem::Base.new('words', r.rand(10..40)).output)
      }
  }

