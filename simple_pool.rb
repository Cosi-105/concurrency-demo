POOL_SIZE = 10

class SimplePool
  def run(count)
    jobs = Queue.new
    count.times{|i| jobs.push i}

    @workers = (POOL_SIZE).times.map do
      Thread.new do
        begin      
          while x = jobs.pop(true)
            Mailer.deliver do 
              from    "eki_#{x}@eqbalq.com"
              to      "jill_#{x}@example.com"
              subject "Threading and Forking (#{x})"
              body    "Some content"
            end        
          end
        rescue ThreadError
        end
      end
    end
    self
  end

  def cleanup
    @workers.map(&:join)
  end
end
