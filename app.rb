require_relative 'config/env'
require_relative 'lib/roda_utils'
require_relative 'lib/view_helpers'

class App < Roda
  plugin :render, engine: 'haml'
  plugin :multi_route
  plugin :partials
  plugin :all_verbs
  plugin :not_found
  plugin :error_handler
  plugin :public
  plugin :json
  plugin :http_auth, authenticator: -> (_, pass) { pass == AUTH_PASSWORD }, realm: 'Please enter ANY username and the password'

  include RodaUtils
  include ViewHelpers

  route do |r|

    r.root {
      http_auth
      @balances = Balance.all
      @bal_total = @balances.sum{ |bal| bal[:usd] || 0 }
      view 'index'
    }

    r.is('candles', String) { |asset|
      r.get {
        Candle.asset asset
      }
    }

    r.public if DOCKER || APP_ENV != "production"
  end

  not_found do
    view "not_found"
  end

  error do |err|
    case err
    when nil
      # catch a proper error...
    #
    # when CustomError
    #   "ERR" # like so
    else
      raise err
    end
  end
end
