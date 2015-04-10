# Call the fake mailer <count> times, in a forked process
class Forking
  def run(count)
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
    self
  end

  def cleanup
    Process.waitall 
  end
end
