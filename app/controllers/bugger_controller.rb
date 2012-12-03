class BuggerController < ApplicationController

  before_filter :setup

  respond_to :html, :js, :png

  def show
    respond_with do |f|
      f.html { }
      f.png { render text: BuggerallConfig.config.image.to_blob, status: 200 }
    end
  end


  # Check for request_signature checksum from cookies, last_modified, etag
  # Find or request signature
  # Add request info to signature
  # Set request_signature chcecksum to cookies, last_modified, etag

  before_filter :setup

  protect_from_forgery

  helper_method :current_resource
  helper_method :marshal_decode
  helper_method :resource_request
  helper_method :request_signature
  helper_method :user_agent


  def current_resource
    return nil if dnt?
    @current_resource ||= Resource.find_or_create_by_path! resource_name
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid resource from request #{request.uuid} in application_controller #{e.inspect}"
    @current_resource = nil
  end


  def dnt?
    false # request.env['HTTP_DNT'].to_i == 1
  end


  def marshal_decode(string)
    return unless string
    Marshal.load Base64.decode64(string)
  rescue TypeError
    nil
  end


  def request_signature
    return nil if dnt?
    @request_signature ||= RequestSignature.find_or_create_by_request! request: request, user_agent: user_agent
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid request_signature from request #{request.uuid} in application_controller #{e.inspect}"
    @request_signature = nil
  end


  def resource_request
    return nil if dnt?
    @resource_request ||= ResourceRequest.create! request_signature: request_signature, resource: current_resource, uuid: request.uuid
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid resource_request from request #{request.uuid} in application_controller #{e.inspect}"
    @resource_request = nil
  end


  def user_agent
    return nil if dnt?
    @user_agent ||= UserAgent.find_or_create_by_agent! request.user_agent
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid user_agent (#{request.user_agent}) from request #{request.uuid} in application_controller #{e.inspect}"
    @user_agent = nil
  end

private

  def resource_name
    params[:resource_name] || request.original_fullpath
  end

  def session_signature_checksum
    signature_checksum_from_cookies || signature_checksum_from_last_modified || signature_checksum_from_etag
  end


  def session_signature_checksum=(checksum)
    cookies.permanent.signed[:signature_checksum] = checksum
    headers["ETag"] = checksum
    headers["Last-Modified"] = checksum
  end


  def setup
    return if dnt?
    self.session_signature_checksum = request_signature.checksum
    headers["Cache-Control"] = 'no-cache'
  end


  def signature_checksum_from_cookies
    marshal_decode cookies[:signature_checksum]
  end


  def signature_checksum_from_etag
    marshal_decode request.env['HTTP_IF_NONE_MATCH']
  end


  def signature_checksum_from_last_modified
    marshal_decode request.env['HTTP_IF_MODIFIED_SINCE']
  end

end
