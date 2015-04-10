# Call the fake mailer count times, in a thread
class Threading
  def run(count)
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
    self
  end

  def cleanup
    @threads.map { |t| t.join}
  end
end