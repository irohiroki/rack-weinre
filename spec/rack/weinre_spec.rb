require 'spec_helper'

describe Rack::Weinre do
  before do
    rackup
  end

  it "passes through" do
    visit '/'
    page.should have_css 'html head'
  end
end
