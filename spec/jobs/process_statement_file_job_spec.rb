require 'rails_helper'
include ActiveJob::TestHelper
ActiveJob::Base.queue_adapter = :test

RSpec.describe ProcessStatementFileJob, type: :job do
  let!(:user) { create(:user) }
  let!(:account) { create(:account, user: user) }
  let!(:brokerage_account) { create(:brokerage_account, account: account) }
  let!(:statement_file) { create(:statement_file, :with_file, account: account) }

  subject(:job) { described_class.perform_later(statement_file_id: statement_file.id) }

  before { allow_any_instance_of(ApplicationController).to receive(:current_user) { user } }

  it 'queues the job' do
    expect { job }
      .to have_enqueued_job(ProcessStatementFileJob)
  end

  it 'is in default queue' do
    expect(ProcessStatementFileJob.new.queue_name).to eq 'default'
  end

  it 'executes perform' do
    perform_enqueued_jobs { job }
  end

  it "performs a job" do
    expect{ described_class.perform_now(statement_file_id: statement_file.id) }
      .to change(Statement, :count).by(1)
  end
end
