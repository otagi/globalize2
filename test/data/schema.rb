ActiveRecord::Schema.define do
  create_table :blogs, :force => true do |t|
    t.string   :description
  end

  create_table :posts, :force => true do |t|
    t.references :blog
  end

  create_table :post_revisions, :force => true do |t|
    t.references :blog
  end

  create_table :post_translations, :force => true do |t|
    t.string     :locale
    t.references :post
    t.string     :subject
    t.text       :content
  end

  create_table :parents, :force => true do |t|
  end

  create_table :parent_translations, :force => true do |t|
    t.string     :locale
    t.references :parent
    t.text       :content
    t.string     :type
  end

  create_table :comments, :force => true do |t|
    t.references :post
  end

  create_table :comment_translations, :force => true do |t|
    t.string     :locale
    t.references :comment
    t.string     :subject
    t.text       :content
  end

  create_table :validatees, :force => true do |t|
  end

  create_table :validatee_translations, :force => true do |t|
    t.string     :locale
    t.references :validatee
    t.string     :string
  end

  create_table :users, :force => true do |t|
    t.string :email
  end

  create_table :users_translations, :force => true do |t|
    t.references :user
    t.string     :name
  end

  create_table :translation_class_extenders, :force => true do |t|
  end

  create_table :translation_class_extender_translations, :force => true do |t|
    t.references :translation_class_extender
    t.string :locale
    t.string :name
  end

  create_table :things, :force => true do |t|
    t.text :content
  end

  create_table :thing_translations, :force => true do |t|
    t.references :thing
    t.string :locale
    t.string :content
  end
end
