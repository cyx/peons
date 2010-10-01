require File.expand_path("./helper", File.dirname(__FILE__))

setup do
  Peons[:fortress]
end

test "adding elements to the queue" do |q|
  q.push "1"
  q.push "2"

  assert ["2", "1"] == q.lrange(0, -1)
end

test "popping from an empty queue" do |q|
  popped = nil 

  q.pop do |e|
    popped = e
  end

  assert nil == popped
end

test "popping from a queue with one element" do |q|
  popped = nil
  
  q.push "1"
  q.pop do |e|
    popped = e
  end

  assert "1" == popped
  assert 0 == q.llen
  assert 0 == q.backup.llen
end

test "popping from a queue with two distinct elements" do |q|
  popped = nil
  
  q.push "1"
  q.push "2"
  
  q.pop do |e|
    popped = e
  end

  assert "1" == popped
  assert 1 == q.llen
  assert 0 == q.backup.llen
end

test "popping from a queue with two equal elements" do |q|
  popped = nil
  
  q.push "1"
  q.push "1"
  
  q.pop do |e|
    popped = e
  end

  assert "1" == popped
  assert 1 == q.llen
  assert 0 == q.backup.llen
end

test "popping and producing an error inside the block" do |q|
  q.push "1"
  q.push "2"
  
  q.pop do |e|
    raise RuntimeError, "Fabrication"
  end
  
  assert 1 == q.llen
  assert 0 == q.backup.llen
  assert 1 == q.errors.llen
  
  assert q.errors.lrange(0, -1).grep(/1 => #<RuntimeError: Fabrication>/).any?
end

test "looping against the queue" do |q|
  q.push "1"
  q.push "2"
  q.push "3"

  output = []

  q.each do |e|
    output << e
  end
  
  assert ["1", "2", "3"] == output

  assert 0 == q.llen
  assert 0 == q.backup.llen
  assert 0 == q.errors.llen
end

