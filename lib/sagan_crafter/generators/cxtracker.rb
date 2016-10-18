module SaganCrafter
  module Generators
    # :: Source of rule data
    # select DISTINCT count(*), max(import_time), name from fqdns group by name;

    # :: Rule output
    # alert tcp $HOME_NET any -> any any (msg: "[PASSIVEDNS] BH1 Hit bighealthtree.com."; content: bighealthtree.com."; normalize: tightstack; classtype: suspicious-traffic; program: tightstack; sid:5100002; rev:2;)
    class CXTracker

      def initialize(ip, feed_provider, feed_name, count, last_time)
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
              'msg' => "[CXTracker] #{feed_provider} #{feed_name} - #{ip}",
              'content' => ip,
              'sid' => XXhash.xxh32(ip) % 1000000000 + 1000000000,
              'normalize' => 'tightstack',
              'program' => 'tightstack',
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
