require "spec_helper"

describe(Tag) do

  it { should have_and_belong_to_many(:articles)}
  it { should validate_presence_of :topic}

end
