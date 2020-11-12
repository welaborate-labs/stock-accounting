require 'rails_helper'
include ActiveJob::TestHelper
ActiveJob::Base.queue_adapter = :test

RSpec.describe ReadingNotesJob, type: :job do
  # TODO
  subject(:job) { described_class.perform_later }

  it { expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1) }
  it { expect(ReadingNotesJob.new.queue_name).to eq('default') }
end
