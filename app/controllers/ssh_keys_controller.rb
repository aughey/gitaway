class SshKeysController < ApplicationController
  before_filter :authenticate
  def index
    @keys = current_user.ssh_keys
  end

  def new
    @key = current_user.ssh_keys.new
  end

  def create
    k = current_user.ssh_keys.create(params[:ssh_key])
    redirect_to '/ssh_keys'
  end
end
