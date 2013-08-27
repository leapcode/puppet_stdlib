module Puppet::Parser::Functions
  newfunction(:obfuscate_email, :type => :rvalue, :doc => <<-EOS
Given:
  an email in form of john@doe.com

This function will return an obfuscated email in form of 'john {at} doe {dot} com' 

    EOS
  ) do |args|
    email=args[0]
    email["@"]= " {at} "
    email=email.gsub(/(.*)(\.)(.*)/, '\1 {dot} \3')
    email
  end
end

# vim: set ts=2 sw=2 et :
# encoding: utf-8
