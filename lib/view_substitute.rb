class ViewSubstitute
  
  def self.get
    Thread.current[:view_substitute]
  end
  
  def self.set(with_view_context)
    Thread.current[:view_substitute] = with_view_context
  end
  
end