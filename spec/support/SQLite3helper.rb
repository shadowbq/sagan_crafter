require 'sqlite3'

module SQLite3helper
  def test_fqdn_db
    @connection = SQLite3::Database.new(':memory:')
    @connection.results_as_hash = true

    @connection.execute(<<-EOS)
    CREATE TABLE IF NOT EXISTS fqdns (
        id INTEGER PRIMARY KEY,
        feed_provider varchar(255),
        feed_name varchar(255),
        import_time timestamp default (strftime('%s', 'now')),
        name varchar(255),
        CONSTRAINT name_unique UNIQUE (import_time, name)
      )
    EOS

    @stmt = @connection.prepare(<<-EOS)
      INSERT INTO fqdns (import_time, name, feed_provider, feed_name) VALUES(:import_time, :name, :feed_provider, :feed_name)
    EOS


    @stmt.execute(:import_time => 1477926621, :name => "futuras.com", :feed_provider => "vxvault", :feed_name => "url_reputation")
    @stmt.execute(:import_time => 1477926621, :name => "kingskillz.ru", :feed_provider => "vxvault", :feed_name => "url_reputation")
    @stmt.execute(:import_time => 1477926621, :name => "djronla.com", :feed_provider => "vxvault", :feed_name => "url_reputation")
    @stmt.execute(:import_time => 1477926621, :name => "naratipsittisook.com", :feed_provider => "vxvault", :feed_name => "url_reputation")
    @stmt.execute(:import_time => 1477926621, :name => "europconomi.com", :feed_provider => "vxvault", :feed_name => "url_reputation")

    @stmt.execute(:import_time => 1477926622, :name => "futuras.com", :feed_provider => "vxvault", :feed_name => "url_reputation")
    @stmt.execute(:import_time => 1477926622, :name => "kingskillz.ru", :feed_provider => "vxvault", :feed_name => "url_reputation")

    @stmt.execute(:import_time => 1477926623, :name => "futuras.com", :feed_provider => "tester", :feed_name => "url_reputation")

    @connection
  end

end
