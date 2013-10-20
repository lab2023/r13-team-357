require "spec_helper"

describe ChecklistsController do
  describe "routing" do

    it "routes to #index" do
      get("/checklists").should route_to("checklists#index")
    end

    it "routes to #new" do
      get("/checklists/new").should route_to("checklists#new")
    end

    it "routes to #show" do
      get("/checklists/1").should route_to("checklists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/checklists/1/edit").should route_to("checklists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/checklists").should route_to("checklists#create")
    end

    it "routes to #update" do
      put("/checklists/1").should route_to("checklists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/checklists/1").should route_to("checklists#destroy", :id => "1")
    end

  end
end
