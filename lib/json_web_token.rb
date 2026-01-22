class JsonWebToken
    RAILS_SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, RAILS_SECRET_KEY)
    end

    def self.decode(token)
        decoded = JWT.decode(token, RAILS_SECRET_KEY).first
        HashWithIndifferentAccess.new decoded
    end
end
