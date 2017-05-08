module ApplicationHelper
  # Custom array methods
  Array.class_eval do
    def clean_empty
      self.reject! { |e| e.to_s.empty? }
    end
  end
end
