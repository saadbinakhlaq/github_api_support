class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from Octokit::UnprocessableEntity, with: :github_api_errors

  private

  def github_api_errors(exception)
    flash[:error] = exception.message
    redirect_to '/github/search'
  end
end
