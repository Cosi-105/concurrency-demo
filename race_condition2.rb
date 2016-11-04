@balance = 0
count = 100
t1 = Thread.start do
  count.times do
    @balance = @balance + 100
    sleep 0.0000001
  end
  puts "[t1] Balance is $#{@balance}      (after adding $100 x #{count})\n"
  count.times do
    @balance = @balance - 100
  end
  sleep(rand(0..2))
  puts "[t1] Balance is $#{@balance}     (after subtracting $100 x #{count})\n"
end

t2 = Thread.start do
  count.times do
    @balance = @balance + 100
  end
  puts "[t2] Balance is $#{@balance}       (after adding $100 x #{count})\n"
  count.times do
    @balance = @balance - 100
    sleep 0.0000001
  end
  sleep(rand(0..2))
  puts "[t1] Balance is $#{@balance}      (after subtracting $100 x #{count})\n"
end

t1.join
t2.join

<<<<<<< HEAD

=======
>>>>>>> 5af667da3516eb6509e6fc0df4d3e4aca87fa450
puts "\n\n*** Final Balance should be zero!"
puts "\n*** Actual Balance is $#{@balance}\n\n"
