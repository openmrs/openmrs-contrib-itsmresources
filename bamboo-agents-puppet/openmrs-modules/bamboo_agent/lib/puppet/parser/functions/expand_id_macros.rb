module Puppet::Parser::Functions
  newfunction(:expand_id_macros, :type => :rvalue) do |args|
    unless args.size == 2 && 
        args[0].kind_of?(Hash)
      raise Puppet::ParseError.new('expand_id_macros expects hash and a string as arguments')
    end
    hash,id = args

    macro = '!ID!'

    expand = lambda do |value|
      value.to_s.gsub(macro,id.to_s)
    end

    expanded = {}
    hash.each_pair do |key,value|
      expanded[expand.call(key)] = expand.call(value)
    end
    expanded
  end
end
