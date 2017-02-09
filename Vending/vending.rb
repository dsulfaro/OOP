require_relative './items.rb'

COINS = {"penny" => 1, "nickle" => 5, "dime" => 10, "quarter" => 25, "half" => 50,
         "dollar" => 1, "two" => 2}


class User
  attr_accessor :wallet

  def initialize(name, wallet=1000)
    @name = name
    @wallet = wallet
  end

  def pay(due)
    @wallet -= due
  end
end

class VendingMachine

#-----------------------------------------------------------------------------#
#--------------------------Transaction----------------------------------------#
#-----------------------------------------------------------------------------#
  class Transaction
    attr_accessor :complete
    attr_reader :store

    def initialize
      @store = Hash.new(0)
      @complete = false
    end

    def cancel
      @store = Hash.new(0)
    end

    def total
      total = 0
      @store.each { |item, num| total += (ITEMS[item][:price] * num) }
      total
    end

    def add_to_cart(item)
      if is_available?(item)
        @store[item] += 1
      else
        puts "No more of that item"
        sleep(1)
      end
    end

    def print
      puts "You got #{@store} in your cart"
    end


    def is_available?(item)
      ITEMS[item][:stock] > @store[item]
    end
  end
#-----------------------------------------------------------------------------#
#----------------------End Transaction----------------------------------------#
#-----------------------------------------------------------------------------#

  def initialize(user, items=ITEMS, cash=1000)
    @items = items
    @cash = cash
    @order = Transaction.new
    @user = user
  end

  def reset(items=ITEMS)
    @items = items
  end

  def run
    until @order.complete
      print_status
      prompt
      handle_choice
    end
    farewell
  end

  private

  def accept_coin
  end

  def handle_choice
    choice = gets.chomp.downcase.to_sym
    puts ""
    case choice
    when :submit
      dispense
      @order.complete = true
    when :cancel
      @order.cancel
      @order.complete = true
    else
      if @items.keys.include?(choice)
        @order.add_to_cart(choice)
      else
        puts "Invalid Request, please try again."
        sleep(1)
      end
    end
  end

  def dispense
    balance = @order.total
    @user.pay(balance)
    remove_items
    @order.print
  end

  def remove_items
    @order.store.each { |k, v| @items[k][:stock] -= v }
  end

  def prompt
    puts ""
    puts "  Select an option by typing its name:"
    puts "    Candy(10) -- Snack(50) -- Nuts(90)"
    puts "    Coke(25) -- Pepsi(35) -- Soda(45)"
    puts "  Submit -- Cancel"
    puts ""
  end

  def farewell
    puts "You have #{@user.wallet} left"
    puts "Goodbye"
    puts ""
  end

  def print_status
    system "clear"
    puts "You have #{@user.wallet - @order.total} in change"
    @order.print
  end

end

you = User.new("Dan")
machine = VendingMachine.new(you)
machine.run
