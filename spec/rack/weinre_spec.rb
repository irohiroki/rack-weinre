require 'spec_helper'

describe Rack::Weinre do
  let(:rack)   { described_class.new(app) }
  let(:app)    { double('app').tap{|a| a.stub(:call).and_return(app_res) } }
  let(:app_res){ [200, {'Content-Type' => 'text/html'}, ['<html><head></head></html>']] }

  it "passes through" do
    rack.call({}).should == app_res
  end
end
