class GithubController < ApplicationController

  def search
    repositories = Github.search(query_params, page: current_page, per_page: per_page)
    @results     = add_paginate(repositories)
    @count       = repositories.total_count
  end

  private

  def query_params
    params[:query]
  end

  def current_page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 30
  end

  def add_paginate(repositories)
    WillPaginate::Collection.create(current_page, per_page, repositories.total_count) do |pager|
      pager.replace(repositories.items)
    end
  end
end
