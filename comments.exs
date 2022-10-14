def comments(assigns) do
  ~H"""
  <div class="comments">
    <%= f = form_for(:comments, "#", phx_submit: :submit_comment) %>

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
