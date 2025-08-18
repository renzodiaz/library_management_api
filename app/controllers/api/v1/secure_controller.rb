class Api::V1::SecureController < ApplicationController
  include Pundit::Authorization
end
