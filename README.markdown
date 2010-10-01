Peons
=====

Peons

_n. Hard working dependable slaves, with a keen attention to mining your gold._

Quick Start
-----------

It's easy to get started with Peon.

    $ [sudo] gem install peons
    $ redis-server # Assuming you have redis-server installed and in your path

    require "peons"

    Peons[:fortress].push "1"
    Peons[:fortress].push "2"
    Peons[:fortress].push "3"
    Peons[:fortress].push "4"

    output = []

    Peons[:fortress].each do |item|
      output << item
    end

    output == ["1", "2", "3", "4"]
    # => true

### Atomic Pops

You can also do atomic pops, if you'd prefer that over looping your entire 
queue.

    Peons[:fortress].push "1"
    
    popped = nil

    Peons[:fortress].pop do |item|
      popped = item
    end

    popped == "1"
    # => true

### Connecting to a different Redis connection

For cases where you want to connect to a Redis connection which isn't the
default, simply assign like so:

    Peons.redis = Redis.connect(:url => "redis://127.0.0.1:22222/1")

### TODO

1. Testing for thread safety.
2. A sinatra web interface to display all queues
3. General hardening.

