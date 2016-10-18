module SaganCrafter
  module Generators
    # :: Source of rule data
    # select DISTINCT count(*), max(import_time), name from fqdns group by name;

    # :: Rule output
    # alert tcp $HOME_NET any -> any any (msg: "[PASSIVEDNS] BH1 Hit bighealthtree.com."; content: bighealthtree.com."; normalize: tightstack; classtype: suspicious-traffic; program: tightstack; sid:5100002; rev:2;)
    class IPlogger

      def initialize(ioc, feed_provider, feed_name, count, last_time)
        @rule = Snort::Rule.new(
          {
            :enabled => true,
            :action => 'alert',
            :proto => 'tcp',
            :src => '$HOME_NET',
            :sport => 'any',
            :dir => '<>',
            :dst => 'any',
            :dport => 'any',
            :options => {
              'msg' => "[#{SaganCrafter::Settings.iplogger}] #{feed_provider} #{feed_name} - #{ioc}",
              'content' => "\"#{ioc}\"",
              'sid' => XXhash.xxh32(ioc) % 1000000000 + 1000000000,
              'normalize' => SaganCrafter::Settings.normalizer,
              'program' => SaganCrafter::Settings.program,
              'rev' => count,
              'metadata' => "time #{last_time}"
              }
            }
        )
      end

      def to_s
        @rule.to_s
      end

    end
  end
end
