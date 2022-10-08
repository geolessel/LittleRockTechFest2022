defmodule LrtfWeb.PageLive do
  use LrtfWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket), do: Lrtf.subscribe(self())

    companies = Lrtf.list_companies()
    {:ok, assign(socket, companies: companies)}
  end

  def render(assigns) do
    LrtfWeb.PageView.render("index.html", assigns)
  end
end
