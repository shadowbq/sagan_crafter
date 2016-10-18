module SaganCrafter
  module Backends
    # :: Source of rule data
    # select DISTINCT count(*), max(import_time), name from fqdns group by name;

    # :: Rule output
    # alert tcp $HOME_NET any -> any any (msg: "[PASSIVEDNS] BH1 Hit bighealthtree.com."; content: bighealthtree.com."; normalize: tightstack; classtype: suspicious-traffic; program: tightstack; sid:5100002; rev:2;)

    # CREATE TABLE fqdns ( id INTEGER PRIMARY KEY, feed_provider varchar(255), feed_name varchar(255), import_time timestamp default (strftime('%s', 'now')), name varchar(255), CONSTRAINT name_unique UNIQUE (import_time, name) )

    class SQLite
      def initialize(file)

        @db = connect(file)

        # Log this
        # > count = db.get_first_value("select count(DISTINCT name) from fqdns")
        # > puts "#{}count(*): #{count}"
        @db.results_as_hash = true

      end

      def size
        # Log this
        count = db.get_first_value("select count(DISTINCT name) from fqdns")
        puts "#{}count(*): #{count}"
      end

      def validate!
        @db.execute('PRAGMA table_info(fqdns);') do |row|
          raise UnknownDBSchemaError, "Unknown Schema" unless ["id","feed_provider","feed_name", "import_time","name"].include? row["name"]
        end
        puts "valid schema" if SaganCrafter::Settings.verbose
      end

      def print
        @db.execute('select DISTINCT count(*) as cnt, max(import_time) as max_import_time, name, feed_name, feed_provider from fqdns group by name') do |row|
          puts SaganCrafter::Generators::PDNS.new(row["name"], row["feed_provider"], row["feed_name"], row["cnt"], row["max_import_time"]).to_s
        end
      end

      private

      def connect(file)
        begin
          db = SQLite3::Database.open(file)
          return db
        rescue ::SQLite3::Exception => e
          puts "Exception occurred"
          puts e
          db.close if db
        end
      end

    end
  end
end
