defmodule LrtfWeb.PageLive do
  use LrtfWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket), do: Lrtf.subscribe(self())

    companies = Lrtf.list_companies()
    {:ok, assign(socket, companies: companies)}
  end

  def handle_info({:new_prices, companies}, socket) do
    {:noreply, assign(socket, :companies, companies)}
  end

  def render(assigns) do
    ~H"""
    <div style="display: flex;">
      <div class="prices">
        <h3>Prices</h3>
        <table>
          <thead>
            <tr>
              <th>Symbol</th>
              <th>Name</th>
              <th class="right">Latest Price</th>
            </tr>
          </thead>

          <tbody>
            <%= for company <- @companies do %>
              <tr>
                <td><%= company.ticker %></td>
                <td><%= company.name %></td>
                <td class="right">
                  <%= :erlang.float_to_binary(company.price, [decimals: 2]) %>
                </td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
    </div>
    """
  end
end
