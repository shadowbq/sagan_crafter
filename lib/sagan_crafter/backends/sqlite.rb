module SaganCrafter
  module Backends
    # :: Source of rule data
    # select DISTINCT count(*), max(import_time), name from fqdns group by name;

    # :: Rule output
    # alert tcp $HOME_NET any -> any any (msg: "[PASSIVEDNS] BH1 Hit bighealthtree.com."; content: bighealthtree.com."; normalize: tightstack; classtype: suspicious-traffic; program: tightstack; sid:5100002; rev:2;)

    # CREATE TABLE fqdns ( id INTEGER PRIMARY KEY, feed_provider varchar(255), feed_name varchar(255), import_time timestamp default (strftime('%s', 'now')), name varchar(255), CONSTRAINT name_unique UNIQUE (import_time, name) )

    # ATTACH DATABASE '/tmp/oph_threat.db' As 'O';

    # create temp view merge_fqdns as select * from F.fqdns union select * from M.fqdns union select * from O.fqdns;
    # select DISTINCT count(*) as cnt, max(sub1.import_time) as max_import_time, sub1.name, sub1.feed_name, sub1.feed_provider from (select * from F.fqdns union select * from M.fqdns union select * from O.fqdns) sub1 group by sub1.name;

    class SQLite

      attr_reader :rule_collection

      def initialize(factory)
        @db = connect(SaganCrafter::Settings.sql_file_location)
        @factory = factory
        @db.results_as_hash = true
        @rule_collection = []
      end

      def size
        count = db.get_first_value("select count(DISTINCT name) from #{SaganCrafter::Settings.sql_table_name}")
        puts "#{}count(*): #{count}"
      end

      def validate!
        @db.execute("PRAGMA table_info(#{SaganCrafter::Settings.sql_table_name});") do |row|
          raise UnknownDBSchemaError, "Unknown Schema" unless ["id","feed_provider","feed_name", "import_time","name"].include? row["name"]
        end
        puts "#[sagan-crafter] schema validated" if SaganCrafter::Settings.verbose
      end

      def build
        @db.execute("select DISTINCT count(*) as cnt, max(import_time) as max_import_time, name, feed_name, feed_provider from #{SaganCrafter::Settings.sql_table_name} group by name") do |row|
          @rule_collection << @factory.rule(row["name"], row["feed_provider"], row["feed_name"], row["cnt"], row["max_import_time"])
        end
        @rule_collection
      end

      def to_s
        @rule_collection.to_s
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
