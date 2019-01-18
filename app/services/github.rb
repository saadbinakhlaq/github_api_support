class Github
  API_KEY = Rails.application.secrets.github_api_key

  Response = Struct.new(:items, :total_count)

  def self.search(query, page:, per_page:)
    client = new
    client.search(query, page: page, per_page: per_page)
  end

  def search(query, page:, per_page:)
    return Response.new([], 0) if query.blank?
    response = @client.search_repos(query, page: page, per_page: per_page)
    Response.new(response[:items], response[:total_count])
  end

  def initialize
    @client = Octokit::Client.new(:access_token => Rails.application.secrets.github_api_key)
  end

  private

  def response_object(response)
    Struct.new(:items, :total_count) do
      def items
        response[:items]
      end

      def total_count
        response[:total_count] || 0
      end
    end
  end
end