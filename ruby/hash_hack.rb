class Hash
  def method_missing meth, *args, &block
    if self.has_key? meth.to_s
      self[meth]
    else
      super
    end
  end

  def respond_to_missing? meth
    self.has_key? meth.to_s
  end
end
