class CreateFederailsModerationReports < ActiveRecord::Migration[8.0]
  def change
    create_table :federails_moderation_reports do |t|
      t.string :federated_url
      t.references :federails_actor, null: false, foreign_key: true
      t.string :content
      t.references :object, polymorphic: true, null: false
      t.datetime :resolved_at
      t.string :resolution
      t.timestamps
    end
  end
end
