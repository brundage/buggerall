class BuggerallController < ApplicationController

  before_filter :setup

  respond_to :html, :js, :png

  def show
    respond_with do |f|
      f.html { }
      f.png { render text: BuggerallConfig.config.image.to_blob, status: 200 }
    end
  end


  helper_method :current_visitor
  helper_method :current_resource
  helper_method :marshal_decode
  helper_method :resource_request
  helper_method :request_signature
  helper_method :user_agent


  def current_resource
    @current_resource ||= Resource.find_or_create_by_path! resource_name
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid resource from request #{request.uuid} in application_controller #{e.inspect}"
    @current_resource = nil
  end


  def current_visitor
    return nil if dnt?
    @current_visitor ||= Visitor.find_or_create! id: session_visitor_id
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.info "Visitor not found with ID #{session_visitor_id} from request #{request.uuid} in application_controller #{e.inspect}"
    @current_visitor = Visitor.create!
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid visitor from request #{request.uuid} in application_controller #{e.inspect}"
    @current_visitor = nil
  end


  def marshal_decode(string)
    return unless string
    Marshal.load Base64.decode64(string)
  rescue TypeError
    nil
  end


  def request_signature
    @request_signature ||= RequestSignature.find_or_create_by_request! request: request, user_agent: user_agent, visitor: current_visitor
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid request_signature from request #{request.uuid} in application_controller #{e.inspect}"
    @request_signature = nil
  end


  def resource_request
    @resource_request ||= ResourceRequest.create! request_signature: request_signature, resource: current_resource, uuid: request.uuid
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid resource_request from request #{request.uuid} in application_controller #{e.inspect}"
    @resource_request = nil
  end


  def user_agent
    @user_agent ||= UserAgent.find_or_create_by_agent! request.user_agent
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.info "Invalid user_agent (#{request.user_agent}) from request #{request.uuid} in application_controller #{e.inspect}"
    @user_agent = nil
  end

private

  def dnt?
    false #request.env['HTTP_DNT'].to_i == 1
  end


  def resource_name
    params[:resource_name] || request.original_fullpath
  end

  def session_visitor_id
    visitor_id_from_cookies || visitor_id_from_last_modified || visitor_id_from_etag
  end


  def session_visitor_id=(id)
    cookies.permanent.signed[:visitor_id] = id
    headers["ETag"] = id.to_s
    headers["Last-Modified"] = id.to_s
  end


  def setup
    resource_request  # to make it happen
    if track_visitor? && current_visitor
      self.session_visitor_id = current_visitor.id
      headers["Cache-Control"] = 'no-cache'
    end
  end


  def track_visitor?
    ! dnt?
  end


  def visitor_id_from_cookies
    marshal_decode cookies[:visitor_id]
  end


  def visitor_id_from_etag
    request.env['HTTP_IF_NONE_MATCH']
  end


  def visitor_id_from_last_modified
    request.env['HTTP_IF_MODIFIED_SINCE']
  end

end
