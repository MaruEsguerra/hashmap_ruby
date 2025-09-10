class HashMap
  attr_accessor :load_factor, :capacity
  def initialize(load_factor = 0.75, capacity = 16)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = Array.new(capacity) { [] } # Each bucket is an array, instead of starting with nil
    @size = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord}

    hash_code
  end

  def set(key, value)
    # Grow capacity if necessary
    grow if @size.to_f / @capacity >= @load_factor
    
    # Find the correct bucket
    index = hash(key) % @capacity
    bucket = @buckets[index]

    # Check if key already exists
    bucket.each do |pair|
      if pair[0] == key
        pair[1] = value
        return
      end
    end

    bucket << [key, value]
    @size += 1
  end

  def grow
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity) { [] }
    @size = 0

    old_buckets.each do |bucket|
      bucket.each do |pair|
        set(pair[0], pair[1])
      end
    end
  end

  def get(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length
    bucket = @buckets[index]

    bucket.each do |pair|
      return pair[1] if pair[0] == key
    end

    nil
  end

  def has?(key)
    index = hash(key) % @capacity
    bucket = @buckets[index]

    bucket.each do |pair|
      return true if pair[0] == key
    end

    false
  end

  def remove(key)
    index = hash(key) % @capacity
    bucket = @buckets[index]

    bucket.each_with_index do |pair, i|
      if pair[0] == key
        removed = bucket.delete_at(i)
        @size -= 1
        return removed[1]
      end
    end

    nil
  end

  def length
    @size
  end

  def clear
    @buckets.each(&:clear)
    @size = 0
  end

  def keys
    keys = []

    @buckets.each do |bucket|
      bucket.each do |pair|
        keys << pair[0]
      end
    end

    keys
  end

  def values
    values = []

    @buckets.each do |bucket|
      bucket.each do |pair|
        values << pair[1]
      end
    end

    values
  end

  def entries
    entries = []

    @buckets.each do |bucket|
      bucket.each do |pair|
        entries << pair
      end
    end

    entries
  end
end