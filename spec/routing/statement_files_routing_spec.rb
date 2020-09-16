require "rails_helper"

RSpec.describe StatementFilesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/statement_files").to route_to("statement_files#index")
    end

    it "routes to #new" do
      expect(get: "/statement_files/new").to route_to("statement_files#new")
    end

    it "routes to #show" do
      expect(get: "/statement_files/1").to route_to("statement_files#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/statement_files/1/edit").to route_to("statement_files#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/statement_files").to route_to("statement_files#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/statement_files/1").to route_to("statement_files#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/statement_files/1").to route_to("statement_files#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/statement_files/1").to route_to("statement_files#destroy", id: "1")
    end
  end
end
