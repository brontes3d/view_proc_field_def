$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'view_substitute'
require 'view_substitute_action_controller_extensions'

ActionController::Base.send(:include, ViewSubstituteActionControllerExtensions)

if defined?(FieldDefs)
  FieldDefs.global_defaults do
    default_for_proc_type(:view_proc_in_context) do |field_defs|
      lambda do |value| 
        field_defs.display_proc.call(field_defs.reader_proc.call(value))
      end
    end
    default_for_proc_type(:view_proc) do |field_defs|
      lambda do |value|
        if vs = ViewSubstitute.get
          vs.instance_eval do
            class << self
              self
            end
          end.send(:define_method, 
                   :view_proc_temp_method_from_view_substitute_plugin, 
                   &field_defs.view_proc_in_context)
          vs.view_proc_temp_method_from_view_substitute_plugin(value)
        else
          raise ArgumentError, "Attempt to call view_proc too soon "+
          "(must be called during/after controller action execution begins)"
        end
      end
    end
  end
end