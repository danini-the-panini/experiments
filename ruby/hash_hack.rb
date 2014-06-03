## Hash-Hack (aka hashack)
## Monkey-patch Hash to provide JS-style Hash getting/setting
#
# Slightly safe since we don't allow hacking keys that aren't there
# no nil-returning, no key-creating
# (although if warranted, this might change)
#
# Go forth and Hashack!

class Hash
  def method_missing meth, *args, &block
    meth_s = meth.to_s
    if meth_s.end_with? '='
      meth_s = meth[0...-1]
      if self.has_key? meth_s
        self[meth_s] = args[0]
      else
        meth = meth_s.to_sym
        if self.has_key? meth
          self[meth] = args[0]
        else
          super
        end
      end
    else
      if self.has_key? meth
        self[meth]
      elsif self.has_key? meth_s
        self[meth_s]
      else
        super
      end
    end
  end

  def respond_to_missing? meth
    meth = meth[0...-1] if meth.end_with? '='
    self.has_key?(meth) || self.has_key?(meth.to_s)
  end
end
