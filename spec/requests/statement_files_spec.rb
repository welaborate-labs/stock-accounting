 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/statement_files", type: :request do
  # StatementFile. As you add validations to StatementFile, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      StatementFile.create! valid_attributes
      get statement_files_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      statement_file = StatementFile.create! valid_attributes
      get statement_file_url(statement_file)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_statement_file_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      statement_file = StatementFile.create! valid_attributes
      get edit_statement_file_url(statement_file)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new StatementFile" do
        expect {
          post statement_files_url, params: { statement_file: valid_attributes }
        }.to change(StatementFile, :count).by(1)
      end

      it "redirects to the created statement_file" do
        post statement_files_url, params: { statement_file: valid_attributes }
        expect(response).to redirect_to(statement_file_url(StatementFile.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new StatementFile" do
        expect {
          post statement_files_url, params: { statement_file: invalid_attributes }
        }.to change(StatementFile, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post statement_files_url, params: { statement_file: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested statement_file" do
        statement_file = StatementFile.create! valid_attributes
        patch statement_file_url(statement_file), params: { statement_file: new_attributes }
        statement_file.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the statement_file" do
        statement_file = StatementFile.create! valid_attributes
        patch statement_file_url(statement_file), params: { statement_file: new_attributes }
        statement_file.reload
        expect(response).to redirect_to(statement_file_url(statement_file))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        statement_file = StatementFile.create! valid_attributes
        patch statement_file_url(statement_file), params: { statement_file: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested statement_file" do
      statement_file = StatementFile.create! valid_attributes
      expect {
        delete statement_file_url(statement_file)
      }.to change(StatementFile, :count).by(-1)
    end

    it "redirects to the statement_files list" do
      statement_file = StatementFile.create! valid_attributes
      delete statement_file_url(statement_file)
      expect(response).to redirect_to(statement_files_url)
    end
  end
end
