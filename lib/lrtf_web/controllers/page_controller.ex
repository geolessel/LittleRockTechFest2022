defmodule LrtfWeb.PageController do
  use LrtfWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", companies: Lrtf.list_companies())
  end
end
