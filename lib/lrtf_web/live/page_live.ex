defmodule LrtfWeb.PageLive do
  use LrtfWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket), do: Lrtf.subscribe(self())

    companies = Lrtf.list_companies()
    comments = Lrtf.list_comments()

    {:ok, assign(socket, comments: comments, companies: companies)}
  end

  def handle_info({:new_prices, companies}, socket) do
    {:noreply, assign(socket, :companies, companies)}
  end

  def handle_info({:new_comment, comment}, socket) do
    {:noreply, assign(socket, comments: [comment])}
  end

  def handle_event("submit_comment", %{"comments" => %{"text" => text}}, socket) do
    Lrtf.insert_comment(text)

    {:noreply, socket}
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
      <.comment_form comments={@comments} />
    </div>
    """
  end

  def comment_form(assigns) do
    ~H"""
    <div class="comments">
      <%= f = form_for(:comments, "#", [phx_submit: :submit_comment]) %>

      <div class="comment-form">
        <h3>Comments</h3>
        <%= text_input(f, :text) %>
      </div>

      <div id="comments-container">
        <%= for comment <- @comments do %>
          <div class="comment" id={"comment_#{comment.id}"}><%= comment.text %></div>
        <% end %>
      </div>
    </div>
    """
  end
end
