$items = ["table", "chair", "bed", "box", "lamp", "cup", "plate", "vase", "desk", "painting", "sculpture", "plate", "tray", "basket", "pitcher", "spoon", "fork", "lamp", "inkwell", "pen", "seal", "drawing", "pulley"]
$age = ["16th", "17th", "17th", "18th", "18th","18th","18th", "19th", "19th","19th","19th","19th","19th","19th","19th","19th","20th","20th","20th","20th","20th","20th","20th","20th","20th","20th","20th","20th"]

class Item 
  
  def initialize()
    @name = $items[rand(0..$items.length - 1)]
    @age = $age[rand(0..$age.length - 1)]
    @value = rand(1000)
    @cost = rand(750)
  end 
  
  attr_reader :name, :age, :value, :cost
end 

class Sell 
  def initialize(player)
    @player = player
  end 
  
  def sell()
    customers = rand(1..5)
    
    if customers >= @player.inventory.count
      customers = @player.inventory.count
    else 
      print "this shouldn't happen"
    end 
      
    
    puts "You have #{customers} customers"
    
    while customers != 0
      customers -= 1
      items = @player.inventory.count - 1
      if items >= 0
        index = rand(0..items)
        offer_item = @player.inventory[index]
        puts "You have an offer of $#{offer_item[2]} on the #{offer_item[1]} century #{offer_item[0]}"
        puts "You paid $#{offer_item[3]}"
        puts "Do you want to take it?"
        puts "yes or no?"
        puts "> "
      
        answer = $stdin.gets.chomp
      
        if answer == "yes"
            @player.sell_item(index)
        elsif answer == "no"
          puts "ok next item"
        else 
          puts "I'll take that as a no, next item"
        end 
      else 
        puts "Your inventory is empty!"
      end 
    end 
    puts "No more customers for today"
    puts "You drive home and go to bed"
    n_day = DayStart.new(@player)
    n_day.new_day()
  end 
end 

class Buy 
  
  def initialize(player)
    @today_items = []
    @player = player
  end 
  
  def buy()
    finds = rand(1..5)
    
    while finds != 0
      finds -= 1
      nitem = Item.new()
      today_items = [[nitem.name, nitem.age, nitem.value, nitem.cost]]
      @today_items.concat(today_items)
    end 
  
    puts "You go out hunting for items"
    puts "You find a store and go inside"
    puts "You see #{@today_items.count} items"
  
    @today_items.each do |item|
      puts "You like the #{item[1]} century #{item[0]}"
    end 
  
    puts "Which do you want to buy?"
    @today_items.each do |item|
      puts "The #{item[1]} century #{item[0]} is $#{item[3]}?"
      puts "Do you want to buy it?"
      puts "yes or no?"
      puts "> "
    
      answer = $stdin.gets.chomp
    
      if answer == "yes"
        @player.buy_item([item], item[3])
      elsif answer == "no"
        puts "Ok next item"
      else 
        puts "I'll take that as a no"
      end 
    end
    
    puts "No more items for today"
    puts "You drive home and go to bed"
    n_day = DayStart.new(@player)
    n_day.new_day()
  end 
end 

class DayStart 
  
  def initialize(player)
    @player = player
  end
  
  def new_day()
    @player.day += 1
    puts "Welcome to a new day it is day #{@player.day}"
    puts "What would you like to do?"
    puts "Buy or Sell"
    puts "> "
    
    answer = $stdin.gets.chomp
    
    if answer == "Buy"
      day = Buy.new(@player)
      day.buy()
    elsif answer == "Sell"
      day = Sell.new(@player)
      day.sell()
    elsif answer == "quit"
      puts "Goodbye"
      exit(1)
    else 
      puts "Sorry I didn't understand"
      DayStart(@player).newday()
    end 
  end 
  
end 

class Engine 
  
  def initialize(player)
    @player = player
  end 
  
  def play(scene)
    game = DayStart.new(@player)
    game.new_day()
  end 
  
end 

class Player
  def initialize()
    @inventory = []
    @money = 500
    @day = 0
  end 
  
  def buy_item(item, cost)
    if @money > cost
      @inventory.concat(item)
      @money -= cost
       puts "Your inventory has the following:"
      @inventory.each do |item|
        puts "The #{item[1]} century #{item[0]}"
      end 
      puts "You have $#{@money} left"
    else 
      puts "Sorry you don't have enough!"
      puts "You have $#{@money}"
    end
  end 
  
  def sell_item(index)
    item = @inventory[index]
    value = item[2]
    @money += value
    @inventory.delete_at(index)
    @inventory.each do |item|
      puts "You have a #{item[1]} century #{item[0]} still"
    end 
    puts "You have $#{@money}"
  end 
  
  attr_accessor :inventory, :money, :day
  
end 

player = Player.new()
game = Engine.new(player)
game.play('start')
