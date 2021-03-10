class Oystercard

attr_accessor :balance, :entry_station, :history, :journey
DEFAULT_BALANCE = 90
MINIMUM_FARE = 1
# COMPLETE_JOURNEY = { entry: nil, exit: nil }

  def initialize
    @balance = 0
    @entry_station = nil
    @history = []
    @journey = { entry: nil, exit: nil }
  end

  def top_up(amount)
    raise "Balance exceeds limit of £#{DEFAULT_BALANCE}" if (@balance + amount) > DEFAULT_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station != nil ? true : false
  end

  def touch_in(station)
    raise "Insufficient funds on card" if @balance < MINIMUM_FARE
    @entry_station = station
    @journey[:entry] = station
  end

  def touch_out(station)
    @balance -= MINIMUM_FARE
    @journey[:exit] = station
    journey_to_history
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def journey_to_history
    @history << @journey
    @journey = { entry: nil, exit: nil }
  end

end
