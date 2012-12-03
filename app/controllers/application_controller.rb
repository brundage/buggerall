class ApplicationController < ActionController::Base

  # Check for user_id from cookies, last_modified, etag
  # Find or create user
  # Add request info to user
  # Set user_id to cookies, last_modified, etag

  before_filter :setup

  protect_from_forgery

  helper_method :current_user
  helper_method :current_resource
  helper_method :marshal_decode
  helper_method :request_signature
  helper_method :resource_request
  helper_method :user_agent


  def bugit
    resource_request
    request_signature
  end


  def current_resource
    return nil if dnt?
    @current_resource ||= Resource.find_or_create_by_path! resource_name
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid resource from request #{request.uuid} in application_controller #{e.inspect}"
    @current_resource = nil
  end


  def current_user
    return nil if dnt?
    @current_user ||= User.find_or_create! id: session_user_id
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.info "User not found with ID #{session_user_id} from request #{request.uuid} in application_controller #{e.inspect}"
    @current_user = User.create!
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid user from request #{request.uuid} in application_controller #{e.inspect}"
    @current_user = nil
  end


  def dnt?
false#;    request.env['HTTP_DNT'].to_i == 1
  end


  def request_signature
    return nil if dnt?
    @request_signature ||= RequestSignature.create_by_request! request: request
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid request_signature from request #{request.uuid} in application_controller #{e.inspect}"
    @request_signature = nil
  end


  def marshal_decode(string)
    return unless string
    Marshal.load Base64.decode64(string)
  rescue TypeError
    nil
  end


  def resource_request
    return nil if dnt?
    @resource_request ||= ResourceRequest.find_or_create_by_request request: request, resource: current_resource, user: current_user, user_agent: user_agent
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

  def session_user_id
    user_id_from_cookies || user_id_from_last_modified || user_id_from_etag
  end


  def session_user_id=(id)
    cookies.permanent.signed[:user_id] = id
    headers["ETag"] = cookies[:user_id]
    headers["Last-Modified"] = cookies[:user_id]
  end


  def setup
    return if dnt?
    bugit
    self.session_user_id = current_user.id
    headers["Cache-Control"] = 'no-cache'
  end


  def user_id_from_cookies
    marshal_decode cookies[:user_id]
  end


  def user_id_from_etag
    marshal_decode request.env['HTTP_IF_NONE_MATCH']
  end


  def user_id_from_last_modified
    marshal_decode request.env['HTTP_IF_MODIFIED_SINCE']
  end

end
