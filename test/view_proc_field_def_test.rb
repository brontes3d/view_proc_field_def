require 'rubygems'
require 'test/unit/notification'
require 'test/unit'

#set rails env CONSTANT (we are not actually loading rails in this test, but activerecord depends on this constant)
RAILS_ENV = 'test' unless defined?(RAILS_ENV)

#require field_defs plugin
require File.expand_path(File.dirname(__FILE__) + '/../../field_defs/init')

require 'action_controller'
require 'action_controller/test_case'
require 'action_controller/test_process'

ActionController::Routing::Routes.clear!
ActionController::Routing::Routes.draw do |m|   
  m.resource :exams
  m.connect ':controller/:action/:id'  
end

ActionController::Base.view_paths = [File.join(File.expand_path(File.dirname(__FILE__)), 'vs_rails_root/views')]


require "#{File.dirname(__FILE__)}/../init"

class ViewProcFieldDefTest < ActionController::TestCase
  
  def setup
    require File.expand_path(File.dirname(__FILE__) + '/vs_rails_root/controller_and_model.rb')
        
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_it
    @controller = ExamsController.new
    
    get :via_controller
    assert_response :success
    # puts @response.body
    
    response_via_controller = @response.body

    get :via_substitute
    assert_response :success
    # puts @response.body
    
    response_via_substitute = @response.body
    
    assert_equal(response_via_controller, response_via_substitute)    
    
    get :via_field_defs
    assert_response :success
    # puts @response.body

    response_via_field_defs = @response.body
    
    assert_equal(response_via_controller, response_via_field_defs)
  end
    
end
