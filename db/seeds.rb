Dir['./lib/*.rb'].each { |file| require file }

Tag.delete_all

tags_list = [
  "sinatra",
  "activerecord",
  "ruby",
  "capybara",
  "testing",
  "tdd",
  "rspec",
  "git",
  "agile",
  "osx",
  "rails",
  "ruby on rails",
  "psql",
  "postgres",
  "sql",
  "javascript",
  "ember",
  "oop",
  "object oriented programming",
  "html",
  "css",
  "bootstrap",

]

tags_list.each do |topic|
  Tag.create(topic: topic)
end

Article.delete_all
article_components = [
  ["Test Article", "Test article content", "css"]
]

article_components.each do |name, content, topic|
  tag = Tag.find_by topic: topic
  tag.articles.create(name: name, content: content)
end
