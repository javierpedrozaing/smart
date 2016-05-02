class AddJobIdToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :transcoder_job_id, :string
    add_column :videos, :conversion_status, :string
  end
end
