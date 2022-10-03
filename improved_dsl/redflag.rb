lambda do
  setups = []
  Kernel.send(:define_method, :setup) do |&block|
    setups << block
  end
  Kernel.send(:define_method, :event) do |description, &block|
    setups.each(&:call)
    puts "ALERT: #{description}" if block.call
  end

  Class.new.instance_eval do
    load 'improved_dsl/events.rb'
  end
end.call
