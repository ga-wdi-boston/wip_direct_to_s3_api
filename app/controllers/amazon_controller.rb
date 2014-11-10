class AmazonController < ApplicationController
  def sign_key
    file_name = params[:file_name]
    response = Amazon.sign file_name
    render json: response
  end
end
