
class Dictionary

  def initialize
    @hash = Hash.new
  end

  def add(new)
    if new.is_a?(Hash)
     @hash = @hash.merge(new)
    else
      @hash[new]=nil
    end
    tmp = @hash
  end

  def entries
    @hash
  end

  def keywords
   @hash.keys.sort
  end

  def include?(entry)
    @hash.key?(entry)
  end

  def find(entry)
    new_hash = Hash.new
    @hash.keys.each { |key| new_hash[key] = @hash[key] if key.include?(entry)  }
    new_hash
  end

#
#  def printable
#
#    @hash.each_pair { |key, value| "[#{key}] \"#{value}\"]"  }
##    self.keywords.each {|key| "[#{key}] \"#{@hash[key]}\""  }.join("\n")
##    %Q{[apple] "fruit"\n[fish] "aquatic animal"\n[zebra] "African land animal with stripes"}
#  end
end