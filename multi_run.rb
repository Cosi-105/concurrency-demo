require_relative 'mailer'
require_relative 'simple_pool'
require_relative 'forking'
require_relative 'sync'
require_relative 'threading'
require 'benchmark'

count = 200

# Call the fake mailer <count> times, once after the other
def sync_test(count)
  count.times do |i|
    Mailer.deliver do
      from    "eki_#{i}@eqbalq.com"
      to      "jill_#{i}@example.com"
      subject "Threading and Forking (#{i})"
      body    "Some content"
    end
  end
end

# Call the fake mailer <count> times, in a forked process
def fork_test(count)
  count.times do |i|
    fork do     
      Mailer.deliver do 
        from    "eki_#{i}@eqbalq.com"
        to      "jill_#{i}@example.com"
        subject "Threading and Forking (#{i})"
        body    "Some content"
      end
    end
  end
end

# Call the fake mailer count times, in a thread
def thread_test(count)
  @threads = []
  count.times do |i|
    @threads << Thread.new do     
      Mailer.deliver do 
        from    "eki_#{i}@eqbalq.com"
        to      "jill_#{i}@example.com"
        subject "Threading and Forking (#{i})"
        body    "Some content"
      end
    end
  end
end


Benchmark.bm(14) do |x|
  x.report("sync")        { Sync.new.run(count).cleanup }
  x.report("old sync")    { sync_test(count) }
  x.report("fork")        { Forking.new.run(count).cleanup }
  x.report("old fork")    { fork_test(count); Process.waitall }
  x.report("thread")      { Threading.new.run(count).cleanup }
  x.report("old thread")  { thread_test(count); @threads.map { |t| t.join} }
  x.report("simple pool") { SimplePool.new.run(count).cleanup }
end

puts "\n\nEnd"