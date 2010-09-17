module ViewSubstituteActionControllerExtensions
  
  def self.included(base)
    base.class_eval do
      def perform_action_with_view_substitute(*args)
        ViewSubstitute.set(self.response.template)
        perform_action_without_view_substitute(*args)
      end
      alias_method_chain :perform_action, :view_substitute
    end
  end
  
end