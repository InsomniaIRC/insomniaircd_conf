require 'base64'

class Secure

  def initialize(key)
    @key = Base64.decode64(key)
  end

  def self.random_key
    cipher = OpenSSL::Cipher::AES256.new(:CBC)
    Base64.encode64(cipher.random_key).gsub("\n", "")
  end

  def encrypt(secret)
    cipher = OpenSSL::Cipher::AES256.new(:CBC)
    cipher.encrypt
    cipher.key = @key
    iv = cipher.random_iv
    encrypted = cipher.update(secret) + cipher.final

    Base64.encode64(iv + encrypted).gsub("\n", "")
  end

  def decrypt(input)
    data = Base64.decode64(input)
    cipher = OpenSSL::Cipher::AES256.new(:CBC)
    cipher.decrypt
    cipher.key = @key
    cipher.iv = data[0..15]

    cipher.update(data[16..-1]) + cipher.final
  end

end

