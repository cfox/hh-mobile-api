class CreateUsers < ActiveRecord::Migration
  
  def self.up
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :users, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.uuid :access_token
      t.text :facebook_access_token
      t.string :screen_name
      t.json :properties
    end
  end

  def self.down
    drop_table :users
  end

end
