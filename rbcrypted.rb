# This is, likely, an encrypted ruby script.
# to run encrypted code: RBKEY=examplekey ruby rbcrypted.rb run
# to decrypt encrypted code: RBKEY=examplekey ruby rbcrypted.rb decrypt
# to encrypt decrypted code: RBKEY=examplekey ruby rbcrypted.rb encrypt

require 'openssl'
@password = ENV['RBKEY']

STATIC_IV = '1234567890123456'
STATIC_SALT = '1234567890123456'

def decrypt
  # Write the decrypted code to the DATA part of the file
  # This will overwrite the encrypted code

  # Read the encrypted code from the DATA part of the file
  encrypted = DATA
  cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
  cipher.decrypt
  cipher.iv = STATIC_IV
  digest = OpenSSL::Digest.new('SHA256')

  key = OpenSSL::PKCS5.pbkdf2_hmac(@password, STATIC_SALT, 20000, cipher.key_len, digest)
  cipher.key = key

  cipher.update(encrypted.read.unpack('m')[0]) + cipher.final
end

case ARGV[0]
when 'run'
  code = decrypt
  eval(code)
when 'decrypt'
  decrypted = decrypt

  # Write it to the DATA part of the file, overwriting existing data
  code_content = File.read(__FILE__).split("\n__END__\n").first
  File.write(__FILE__, code_content+"\n__END__\n"+decrypted)
when 'encrypt'
  # Write the encrypted code to the DATA part of the file
  # This will overwrite the decrypted code

  # Read the decrypted code from the DATA part of the file
  cleartext = DATA
  cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
  cipher.encrypt
  cipher.iv = STATIC_IV
  digest = OpenSSL::Digest.new('SHA256')

  key = OpenSSL::PKCS5.pbkdf2_hmac(@password, STATIC_SALT, 20000, cipher.key_len, digest)
  cipher.key = key

  encrypted = cipher.update(cleartext.read) + cipher.final
  # Write it to the DATA part of the file, overwriting existing data
  code_content = File.read(__FILE__).split("\n__END__\n").first
  File.write(__FILE__, code_content+"\n__END__\n\n"+[encrypted].pack('m'))
end


__END__

AEybOeMHjo8ojrrUHiRwqw7nWe7Zppy1Je+7zls56xs=
