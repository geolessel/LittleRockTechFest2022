defmodule LrtfWeb.PageLive do
  use LrtfWeb, :live_view

  def render(_assigns) do
    companies = Lrtf.list_companies()
    LrtfWeb.PageView.render("index.html", companies: companies)
  end
end
