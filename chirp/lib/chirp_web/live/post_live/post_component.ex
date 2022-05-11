defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  def render(assigns) do
    ~H"""
    <div id={"post-#{@post.id}"} class="post">
      <div class="chirp-header">
        <img src={Routes.static_path(@socket, "/images/no-profile-picture.jpg")} alt="Profile picture" class="avatar"/>
        <div class="chirp-header-info">
          <span> @<%= @post.username %> </span>
          <p> <%= @post.body %> </p>
        </div>
      </div>

      <div class="chirp-info-counts">
        <div class="likes">
          <a href="#" phx-click="like" phx-target={ @myself }>
            <i class="fa fa-heart"></i>
          </a>
          <div class="likes-count">
            <%= @post.likes_count %>
          </div>
        </div>
        <div class="reposts">
          <a href="#" phx-click="repost" phx-target={ @myself }>
            <i class="fa fa-retweet"></i>
          </a>
          <div class="repost-count">
            <%= @post.reposts_count %>
          </div>
        </div>

        <div class="actions">
          <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
            <i class="fa fa-edit"></i>
          <% end %>
          <%= link to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] do %>
            <i class="fa fa-trash-alt"></i>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
