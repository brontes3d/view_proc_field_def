class Exam
  
  def to_s
    "hi"
  end
  
  def self.field_defs
    @@field_definitions ||= FieldDefs.new(Exam) do
      
      field(:link_to_exams).view_proc_in_context do |exam|
        link_to("hi", exams_path(exam))
      end
      
    end
  end
  
end
class ExamsController < ActionController::Base
    
  def via_controller
  end

  def via_substitute
    render :text => ViewSubstitute.get.link_to("hi", exams_path(Exam.new))
  end
  
  def via_field_defs
    render :text => Exam.field_defs.field_called(:link_to_exams).view_proc.call(Exam.new)
  end
  
end