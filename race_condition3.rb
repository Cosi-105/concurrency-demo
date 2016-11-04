class Account
  attr_accessor :balance
end

@my_account = Account.new
@my_account.balance = 0

threads = (1..20).map do |i|
  Thread.new(i) do
    curr_balance = @my_account.balance
    sleep(rand(0..2))
    curr_balance += 10
    sleep(rand(0..2))
    @my_account.balance = curr_balance
    puts "my_account.balance=#{@my_account.balance}, curr_balance=#{curr_balance}"
  end
end

threads.each { |t| t.join}
puts "Final Balance = #{@my_account.balance}"
