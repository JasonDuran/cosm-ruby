class Dictionary < Hash

  attr_accessor :keywords, :entries
  
  def initialize 
    @entries = {}
    @keywords = []
  end
 
  def add(defs)
    #Preconditions
    #1. defs can not be nil
    if defs == nil   
      raise "defs can not be null"
    end

    #2. defs must be a hash
    defs = {defs => nil} unless defs.kind_of?(Hash)

    #Main
    defs.each do |k, v|
      @entries[k] = v
    end

  end

  def find(expr)
    #Preconditions
    #1. Expr can not be nil
    if expr == nil   
      raise "expr can not be null"
    end

    #2. String Expr must not be empty
    if expr == String && expr.length < 1
      raise "Expr is an empty string"
    end

    #Main - find values by key
    results_hash = {}
    @entries.each do |k, v|
      if k[expr] != nil
        results_hash[k] = v
      end
    end 
    return results_hash
  end
  
  def keywords
    #Main - Alpha/Num Sort of Keys
    input = []
    @entries.each do |k, v|
      input << k
    end
    input.sort  
  end
  
  def include?(key)
    #Preconditions
    #1. Not nil
    if keys == nil
      raise "Nil passed in for key"
    end

    #2. String key can not be empty
    case keys
      when String
        if keys.length == 0
          raise "Empty String Passed in"
        end
    end

    #Main - Is key already in the hash?
    @entries.key?(key)
  end

end
