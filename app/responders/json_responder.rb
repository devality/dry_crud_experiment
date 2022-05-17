class JsonResponder < ActionController::Responder
  def api_behavior(*args, &block)
    if post?
      if resource[:errors]
        display(resource, status: :bad_request)
      else
        display(resource, status: :created)
      end
    elsif put? || patch?
      display(resource, status: :ok)
    else
      super
    end
  end
end

