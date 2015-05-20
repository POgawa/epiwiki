require "spec_helper"

describe(Article) do
  it { should have_and_belong_to_many(:users)}
  it { should validate_presence_of :name}
  it { should validate_presence_of :content}

  it('downcases the all content in the article') do
    article = Article.create content: "This Is soMe gooD StuFF", name:'Stuff'
    expect(article.content).to eq('this is some good stuff')
  end

  it('downcases the name of the article') do
    article = Article.create content: "This Is soMe gooD StuFF", name:'Stuff'
    expect(article.name).to eq('stuff')
  end

end
