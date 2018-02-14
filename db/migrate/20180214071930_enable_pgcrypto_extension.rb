class EnablePgcryptoExtension < ActiveRecord::Migration[5.2]
  def up
    enable_extension 'pgcrypto'
  end
  def down
    disable_extension 'pgcrypto'
  end
end
