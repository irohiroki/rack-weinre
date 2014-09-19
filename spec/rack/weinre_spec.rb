require 'spec_helper'

describe Rack::Weinre do
  before do
    rackup app, options
    visit '/'
  end

  subject { page }

  let(:app){ stub_app }
  let(:options){ {} }

  context "when response type is text/html" do
    it { should have_css 'head script[src="http://www.example.com:8080/target/target-script-min.js#anonymous"]' }

    context "and Content-Length is given" do
      let(:body){ '<!DOCTYPE html><html><head><title>マルチバイト</title></head><body>bar</body></html>' }
      let(:app){ stub_app(:headers => {'Content-Length' => body.size.to_s}, :body => [body]) }
      it { expect{ subject }.not_to raise_error }
    end
  end

  context "when response type is not text/html" do
    let(:app){ stub_app(:headers => {'Content-Type' => 'text/plain'}) }
    it { should_not have_css 'head script'}
  end

  context "with content type with charset" do
    let(:app){ stub_app(:headers => {'Content-Type' => 'text/html; charset=utf-8'}) }
    it { should have_css 'head script'}
  end

  context "with a :port option" do
    let(:options){ {:port => '8765'} }
    its(:source) { should match 'www.example.com:8765' }
  end

  context "with a :switch option" do
    context "refering a non-existent file" do
      let(:options){ {:switch => 'bogus'} }
      it { should_not have_css 'head script'}
    end

    context "refering a existent file" do
      let(:options){ {:switch => 'Gemfile'} }
      it { should have_css 'head script'}
    end
  end
end
