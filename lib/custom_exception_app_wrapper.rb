# frozen_string_literal: true

class CustomExceptionAppWrapper
  def initialize(exception_app:)
    @exception_app = exception_app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)
    fallback_to_html_format_if_invalid_mime_type(request)
    @exception_app.call(env)
  end

  private

  def fallback_to_html_format_if_invalid_mime_type(request)
    request.format
  rescue ActionDispatch::Http::MimeNegotiation::Invalid
    request.set_header "CONTENT_TYPE", "text/html"
  end
end
