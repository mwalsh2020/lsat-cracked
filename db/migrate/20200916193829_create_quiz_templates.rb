class CreateQuizTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_templates do |t|
      t.references :quizable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
