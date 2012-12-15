require 'spec_helper'

describe BuggerallController do

  let(:cache_control) { response.headers['Cache-Control'] }
  let(:cookie) { controller.marshal_decode(response.cookies['visitor_id']) }
  let(:dnt_header) { request.env['HTTP_DNT'] }
  let(:etag) { response.headers['ETag'] }
  let(:last_modified) { response.headers['Last-Modified'] }


  shared_examples_for :tracked_request do

    it 'sets a visitor_id cookie' do
      cookie.should_not be_blank
    end

    it 'sets no-cache' do
      cache_control.should eq 'no-cache'
    end

    it 'sets an ETag header' do
      etag.should_not be_blank
    end

    it 'sets a last-modified header' do
      last_modified.should_not be_blank
    end

    it 'sets the ETag to last_modified' do
      last_modified.should eq etag
    end

    it 'sets the ETag to visitor_id' do
      etag.should eq cookie
    end

  end


  shared_examples_for :untracked_request do

    it 'does not set a visitor_id cookie' do
      cookie.should be_blank
    end

    it 'does not set no-cache' do
      cache_control.should be_blank
    end

    it 'does not set an ETag header' do
      etag.should be_blank
    end

    it 'does not set a last-modified header' do
      last_modified.should be_blank
    end
  end


  describe 'GET show' do

    shared_examples_for :get_show_html do
      it('responds 200') { assert_response 200 }
      it('renders :show') { response.should render_template :show }
    end

    context 'with no HTTP_DNT header' do
      before do
        get :show, resource_name: :rspec
      end
      it_behaves_like :get_show_html
      it_behaves_like :tracked_request
    end

    context 'with HTTP_DNT turned off' do
      before do
        request.env['HTTP_DNT'] = "0"
        get :show, resource_name: :rspec
      end
      it_behaves_like :get_show_html
      it_behaves_like :tracked_request
    end


    context 'with HTTP_DNT turned on' do
      before do
        request.env['HTTP_DNT'] = "1"
        get :show, resource_name: :rspec
      end
      it_behaves_like :get_show_html
      it_behaves_like :untracked_request
    end

  end


  describe 'GET show.png' do

    shared_examples_for :get_show_png do
      it('responds 200') { assert_response 200 }
      it('responds with an image') { response.content_type.should =~ /image\//i }
    end

    context 'with no HTTP_DNT header' do
      before do
        get :show, format: 'png', resource_name: :rspec
      end
      it_behaves_like :get_show_png
      it_behaves_like :tracked_request
    end

    context 'with HTTP_DNT turned off' do
      before do
        request.env['HTTP_DNT'] = "0"
        get :show, format: 'png', resource_name: :rspec
      end
      it_behaves_like :get_show_png
      it_behaves_like :tracked_request
    end

    context 'with HTTP_DNT turned on' do
      before do
        request.env['HTTP_DNT'] = "1"
        get :show, format: 'png', resource_name: :rspec
      end
      it_behaves_like :get_show_png
      it_behaves_like :untracked_request
    end
  end

end
