require 'jwt'
class JsonWebTokenService
  # Encodes and signs JWT Payload with expiration
  class << self
    def encode(payload)
      payload.reverse_merge!(meta)
      JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
    end

    # Decodes the JWT with the signed secret
    def decode(token)
      JWT.decode(token, Rails.application.credentials.secret_key_base, true, { :algorithm => 'HS256' })
    end

    # Validates the payload hash for expiration and meta claims
    def valid_payload(payload)
      return false if expired(payload) || payload['iss'] != meta[:iss] || payload['aud'] != meta[:aud]
      true
    end

    # Default options to be encoded in the token
    def meta
      {
        exp: 7.days.from_now.to_i,
        iss: 'issuer_name',
        aud: 'client',
      }
    end

    # Validates if the token is expired by exp parameter
    def expired(payload)
      Time.at(payload['exp']) < Time.now
    end
  end
end
