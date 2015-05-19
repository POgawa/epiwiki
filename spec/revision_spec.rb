require "spec_helper"

describe(Revision) do
  it {should validate_presence_of :content}
  it {should belong_to :article}
  it {should belong_to :user}

end
