module ApplicationHelper
  # Custom array methods
  Array.class_eval do
    def clean_empty
      self.reject! { |e| e.to_s.empty? }
    end
  end

  def flash_success(message, redirect_url = nil)
    flash[:success] = message
    redirect_to redirect_url if !redirect_url.nil?
  end

  def flash_danger(message, redirect_url = nil)
    flash[:danger] = message
    redirect_to redirect_url if !redirect_url.nil?
  end

  def flash_warning(message, redirect_url = nil)
    flash[:warning] = message
    redirect_to redirect_url if !redirect_url.nil?
  end

  def flash_info(message, redirect_url = nil)
    flash[:info] = message
    redirect_to redirect_url if !redirect_url.nil?
  end
end
