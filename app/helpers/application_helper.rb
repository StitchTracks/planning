module ApplicationHelper
  def input_mode
    if session[:input_mode] != "basic"
      session[:input_mode] = "rich"
    end
    session[:input_mode]
  end

  def input_mode=(new_mode)
    session.input_mode = new_mode
  end
end
