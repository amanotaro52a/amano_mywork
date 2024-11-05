class SorceryCore < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name                   # 名前
      t.string :email, null: false     # メールアドレス
      t.string :crypted_password       # パスワードハッシュ
      t.string :salt                   # ソルト
      t.string :reset_password_token   # パスワードリセットトークン
      t.datetime :reset_password_token_expires_at # トークンの有効期限
      t.datetime :reset_password_email_sent_at    # リクエスト送信日時
      t.string :remember_me_token      # Remember Meトークン
      t.datetime :remember_me_token_expires_at    # Remember Meトークンの有効期限
      t.integer :access_count_to_reset_password_page, default: 0 # アクセスカウント追加

      t.timestamps
    end

    add_index :users, :email, unique: true   # メールアドレスに対する一意性を保証するインデックスを追加
    add_index :users, :reset_password_token, unique: true # リセットパスワードトークンに対する一意性を保証するインデックスを追加
  end
end