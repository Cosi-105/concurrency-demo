@balance = 0
t1 = Thread.start do
  100.times do 
    @balance = @balance + 100
  end
  puts "[t1] Balance is $#{@balance}      (after adding $100x100)\n"
  100.times do
    @balance = @balance - 100
  end
  puts "[t1] Balance is $#{@balance}     (after subtracting $100x100)\n"
end

t2 = Thread.start do
  100.times do 
    @balance = @balance + 100
  end
  puts "[t2] Balance is $#{@balance}       (after adding $100x100)\n"
  100.times do
    @balance = @balance - 100
  end
  puts "[t1] Balance is $#{@balance}      (after subtracting $100x100)\n"
end

t1.join
t2.join


puts "\n\n*** Final Balance should be zero!" 
puts "\n*** Actual Balance is $#{@balance}\n\n"