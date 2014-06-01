## Generic JSON API ??
#
# This is a wrapper for HTTParty that provides a generic 'hook' onto
# your favourite JSON API. Simple extend SomeAPI and apply options like
# base_uri, then call your new API like you're partying hard.
#
# 'Github' API provided below as an example. :P

require 'httparty'

class SomeAPI
  include HTTParty
  format :json
  default_params output: :json

  %W(get post put patch delete copy move head options).each do |meth|
    define_method meth do
      @meth = meth.to_s
      @path = nil
      @options = {}
      self
    end
  end

  def << obj
    call obj
  end

  def >> options
    call nil, options
  end

  def ! options = {}
    puts "#{@meth}ing #{@path}"
    self.class.send(@meth, @path || "/", @options.merge(options))
  end

  def method_missing meth, *args, &block
    if meth =~ /[a-zA-Z0-9\-_]+[!\?]?/
      meths = meth.to_s
      if meths.end_with?('!') || meths.end_with?('?')
        self[meths[0...-1]]
        self.!(args[0] || {})
      else
        self[meths]
      end
    else
      super
    end
  end

  def respond_to_missing? meth
    meth =~ /[a-zA-Z0-9\-_]+[!\?]?/
  end

  def [] thing
    @path ||= ""
    @path += "/#{thing}"
    self
  end

end

class Github < SomeAPI
  base_uri 'https://api.github.com'
  headers 'User-Agent' => 'jellymann'
end
