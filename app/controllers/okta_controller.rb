require "openssl"
require "base64"
require "jwt"

class OktaController < ApplicationController
  def hello
    @message = "Hello, how are you today?"

    @e = 'AQAB'
    @n = 'kZoa2Z9lluSkW2o78KCdPFE5gsCUUT5GC91yNElC-_i2P01ym2OKnzZa752JTE__OjSxDyMsO-YLXcuayhs3KL2ltrtHcnqbzLs5FOxrvBhPbTtbLyXNb79a9c8KW02jpzjBnzIBIaURBJU6qFCCKrJtzTcECaS-XX_dvvcDhGaopzEE1PCU1hKKYhFb-QKDhFecMvWUcj7BOU_288dQGODTHmoP0kC9eRAkGsfVDLdibNi9SB9DMJGYub8SM7cHjBV1aq3I-eoV7LcQJK7LcjMsaoNQQoRfwz40_5Hm5mLwGU0X2SxJeaXCvsuAfhcHwnsp_QicEBO7inruTPKMiw'

    rsa_public = rsa_public_key(@e, @n)
    puts rsa_public

    @token = 'eyJraWQiOiJvblNhWUNrNWVGNDd6V1ZNbEV5YjhIcEs4TEhwSHdZcTZqSzYxWW5vTjBrIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULm5TNGZZMTBGbXAzYVR6UnpvZDZJcG5WV3BMdF93V3Y2dDNJNHo5R2JIOU0iLCJpc3MiOiJodHRwczovL2Rldi02NzM3NzMub2t0YXByZXZpZXcuY29tL29hdXRoMi9kZWZhdWx0IiwiYXVkIjoiYXBpOi8vZGVmYXVsdCIsImlhdCI6MTU0ODE0MDU1MSwiZXhwIjoxNTQ4MTQ0MTUxLCJjaWQiOiIwb2FqMXByNTczR3VwcnBDRTBoNyIsInVpZCI6IjAwdWRuMm5uNnA0UWZXNWVPMGg3Iiwic2NwIjpbImVtYWlsIiwib3BlbmlkIl0sInN1YiI6IndheWRlLnN1bkBnbWFpbC5jb20ifQ.cXUx2_beb7p48x5sK19i8VhGWpiS2Ah0Y9QBHl--oJ6h8BJawNKBh9He6T6Ry8Z62f4BxaYOlVQTwyMjt5CZ6Cb8EoJrTbfu_1tMGbTTUe3NQRsA_Gs18yr9N84gcSpXf-Kyhj66Fi2gaD_o1D9PIrn6K_C4VSIQc4lXm02kOp2SCnFcSory4zhzSUJrKHE87DYxKND4UNyiFp8NerDxtTDrmF2JgkQSmEIBFrrn-hHIoV8UZvPj_4CDZapBuY-zjrc3zLfkkTMc9Drji9mpn_a4TAEyLMr5_cDGk02ItRjUroUZs-J0ISsuJAFJqUEnEwiF8HQdUt1j9wnEFU8e5Q'

    decoded_token = JWT.decode @token, rsa_public, true, { algorithm: 'RS256' }

    puts '------'
    puts decoded_token


  end

  def rsa_public_key(e, n)
    #
    # big_number_64 = n
    # big_number = Base64.decode64(big_number_64) #input: Base64: output: decoded string
    # big_number = big_number.unpack('B*').first #B*: output = Binary
    # big_number = big_number.to_i(2) #read big_number as binary, output = integer
    # puts big_number

    rsa_key = OpenSSL::PKey::RSA.new
    ke = OpenSSL::BN.new(Base64.urlsafe_decode64(e), 2)
    kn = OpenSSL::BN.new(Base64.urlsafe_decode64(n), 2)
    rsa_key.set_key(kn, ke, nil)

    rsa_key.public_key
  end


end
