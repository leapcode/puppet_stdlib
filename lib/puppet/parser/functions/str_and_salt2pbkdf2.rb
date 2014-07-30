#
# str_and_salt2pbkdf2.rb
#

module Puppet::Parser::Functions
  newfunction(:str_and_salt2pbkdf2, :type => :rvalue, :doc => <<-EOS
This converts a string to an array containing the salted PBKDF2 password hash in
the first field, the salt itself in second field, and the number of iterations
in the third field of the returned array.
This combination is used i.e. for couchdb passwords for couch versions >= 1.3.
    EOS
  ) do |arguments|
    require 'pbkdf2'

    raise(Puppet::ParseError, "str_and_salt2pbkdf2(): Wrong number of arguments " +
      "passed (#{arguments.size} but we require 1)") if arguments.size != 1

    str_and_salt = arguments[0]

    unless str_and_salt.is_a?(Array)
      raise(Puppet::ParseError, 'str_and_salt2pbkdf2(): Requires a ' +
        "Array argument, you passed: #{password.class}")
    end

    str  = str_and_salt[0]
    salt = str_and_salt[1]
    pbkdf2 = PBKDF2.new do |p|
      p.password = str
      p.salt = salt
      p.iterations = 10
      p.hash_function = OpenSSL::Digest::SHA1.new
    end
    return [pbkdf2.hex_string, pbkdf2.salt, pbkdf2.iterations]
  end
end

# vim: set ts=2 sw=2 et :
