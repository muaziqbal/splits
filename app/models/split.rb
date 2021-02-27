class Split
  attr_accessor :id, :name, :duration, :start_time, :finish_time, :best, :history, :indexed_history, :gold, :skipped, :reduced

  def initialize(h = {})
    @id = h[:id]
    @name = h[:name]
    @duration = h[:duration]
    @start_time = h[:start_time]
    @finish_time = h[:finish_time]
    @best = h[:best]
    @history = h[:history]
    @indexed_history = h[:indexed_history]
    @gold = h[:gold?] || h[:gold] || false
    @skipped = h[:skipped?] || h[:skipped] || false
    @reduced = h[:reduced?] || h[:reduced] || false
  end

  def gold?
    gold || false
  end

  def skipped?
    skipped || false
  end

  def reduced?
    reduced || false
  end

  def to_h
    {
      id: id,
      name: name,
      duration: duration,
      start_time: start_time,
      finish_time: finish_time,
      best: best,
      gold: gold,
      skipped: skipped,
    }.compact
  end

  def serializable_hash
    {
      id: id,
      name: name,
      duration: duration,
      start_time: start_time,
      finish_time: finish_time,
      best: best.try(:serializable_hash),
      gold: gold,
      skipped: skipped,
    }.compact
  end
end
