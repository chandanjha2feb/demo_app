class SecretCodesController < ApplicationController
  include CanCan::ControllerAdditions
  load_and_authorize_resource

  def index
    @secret_codes = SecretCode.all
  end

  def new
    @secret_code = SecretCode.new(code_params)
  end

  def multiple_secret_code_create
    case params[:secret_code].to_i
    when 1
      @secret_code = SecretCode.new
      @secret_code.secret_code = Digest::SHA1.hexdigest([Time.now, rand].join)
      @secret_code.save(validate:false)
    when 10
      10.times do |i|
        save_code(i)
      end
    when 20
      20.times do |i|
        save_code(i)
      end
    when 50
      50.times do |i|
      save_code(i)
      end
    when 100
      100.times do |i|
        save_code(i)
      end
    else
      10.times do |i|
        save_code(i)
      end
    end
    redirect_to secret_codes_path
  end

  def create
    @secret_code = SecretCode.new
    @secret_code.secret_code = Digest::SHA1.hexdigest([Time.now, rand].join)
    @secret_code.save(validate:false)
  end

  def show
    @secret_code = SecretCode.find_by(params[:id])
  end

  private

  def code_params
    params.require(:secret_code).permit(:secret_code, :user_id)
  end

  def save_code(i)
    @secret_code = SecretCode.new
    @secret_code.secret_code = Digest::SHA1.hexdigest([i, rand].join)
    @secret_code.save(validate:false)
  end

end
