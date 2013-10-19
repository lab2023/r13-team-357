require "spec_helper"

describe CardsController do
  describe "routing" do

    it "routes to #index" do
      get("/cards").should route_to("cards#index")
    end

    it "routes to #new" do
      get("/cards/new").should route_to("cards#new")
    end

    it "routes to #show" do
      get("/cards/1").should route_to("cards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cards/1/edit").should route_to("cards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cards").should route_to("cards#create")
    end

    it "routes to #update" do
      put("/cards/1").should route_to("cards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cards/1").should route_to("cards#destroy", :id => "1")
    end

  end
end
