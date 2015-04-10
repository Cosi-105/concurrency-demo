# Call the fake mailer <count> times, once after the other
class Sync
  def run(count)
    count.times do |i|
      Mailer.deliver do
        from    "eki_#{i}@eqbalq.com"
        to      "jill_#{i}@example.com"
        subject "Threading and Forking (#{i})"
        body    "Some content"
      end
    end
    self
  end

  def cleanup
  end
end