require 'spec_helper'

describe "Home page" do
  describe "GET /" do
    it "routes /" do
      get '/'
      response.status.should be(200)
    end
  end
end
