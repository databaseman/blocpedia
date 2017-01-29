class CreateCollaborators < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborators do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
#    execute "ALTER TABLE collaborators ADD PRIMARY KEY (user_id, post_id);"
  end
end
