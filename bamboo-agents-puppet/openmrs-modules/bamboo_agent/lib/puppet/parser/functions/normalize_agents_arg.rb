# Convert a string or array agents argument into a hash
# that can be passed to create_resources function
module Puppet::Parser::Functions
  newfunction(:normalize_agents_arg, :type => :rvalue) do |args|
    unless args.size == 1
      raise Puppet::ParseError.new('normalize_agents_arg expects one argument')
    end

    agents = args.first
    case agents
    when String, Integer, Symbol
      { agents.to_s => {} }
    when Array
      Hash[*(agents.map { |a| [a.to_s,{}] }.flatten)]
    when Hash
      final_agents = {}
      agents.each_pair do |key,value|
        val = case value
              when nil,'nil','undef'
                {}
              when Hash
                value
              else
                raise Puppet::ParseError.new("#{value.inspect} " << 
                     'is not a valid resource parameter hash ' << 
                     "for agent id #{key}")
              end
        final_agents[key] = val
      end
      final_agents
    else
      raise Puppet::ParseError.new("#{agents.class} is not valid type of agents argument!")
    end
  end
end
