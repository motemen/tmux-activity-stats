#!/usr/bin/env ruby

KEYS  = %w(cwd title cmd)
stays = Hash.new { |h,k| h[k] = Hash.new(0) }

log = nil

ARGF.each_line do |line|
  last_log, log = log, Hash[ line.chomp.split(/\t/).map { |f| f.split(/:/, 2) } ]
  next unless last_log and last_log['time']
  KEYS.each do |key|
    stays[key][log[key]] += log['time'].to_i - last_log['time'].to_i
  end
end

stays.each do |key,stay|
  puts "# #{key}"
  total = stay.values.inject(:+)
  stay.keys.sort_by { |k| -stay[k] } .each do |k|
    puts "%4ds (%5.1f%%): %s" % [ stay[k], stay[k] * 100.0 / total, k ]
  end
end
