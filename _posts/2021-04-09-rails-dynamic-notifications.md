---
title: Rails dynamic notifications by ajax
categories:
- Fullstack
- Rails
tags:
- rails
- javascript
- notification
- ajax
---

## Controller

```ruby
  def get_data_notification
    per_page = 5
    page = params[:page].present? ? params[:page].to_i : 1
    all_notiff = NotificationServices::GetList.new(current_account).run()
    @total_notification = all_notiff.count
    @count_unread = all_notiff.where(mark_readed: false).count
    @notifications = all_notiff.page(page).per(per_page)
    @current_page_notification = page
    if page.present?
      @next_page_notification = @total_notification > page*per_page ? page + 1 : nil
    else
      @next_page_notification = @total_notification > per_page ? 2 : nil
    end
  end
```

```ruby
  def index
    per_page = 5
    page = params[:page].present? ? params[:page].to_i : 1
    all_notiff = NotificationServices::GetList.new(current_account).run()
    @total_notification = all_notiff.count
    @count_unread = all_notiff.where(mark_readed: false).count
    @notifications = all_notiff.page(page).per(per_page)
    @current_page_notification = page
    if page.present?
      @next_page_notification = @total_notification > page*per_page ? page + 1 : nil
    else
      @next_page_notification = @total_notification > per_page ? 2 : nil
    end
    @page = page
  end
 ```
## ERB
1. page notification erb

```haml
<% if notifications.present? %>
  <div id="itemNotification">
    <% notifications.each.with_index do |nt, index| %>
      <% if index > 0 || current_page_notification > 1 %>
        <hr class="m-0">
      <% end %>
      <%= link_to mark_unread_pages_notification_path(nt), class: "dropdown-item d-flex #{ 'unread-message' unless nt.mark_readed }", style:"position: relative;" do %>
        <div class="mr-2">
          <div class="icon-circle text-center text-uppercase text-white bg-primary bottom-2px" style="height: 30px; width: 30px;">
            <span class="position-relative font-size-12px"><%= parse_letter_name(nt.owner_first_name, nt.owner_last_name) if nt.owner_id.present? %></span>
          </div>
        </div>
        <div>
          <p class="font-size-16px font-weight-bold mb-1"><%= notification_title(nt.view_type, nt.team_name, nt.owner_fullname) %></p>
          <div class="clearfix"></div>
          <p class="font-size-16px text-gray-500 mb-3">"<%= truncate(notification_description(nt, nt.view_type, nt.team_name, nt.objective_name).html_safe, length: 40) %>"</p>
          <div class="font-size-16px text-gray-500"><%= parse_ago_time(nt.created_at, current_account.timezone) %></div>
        </div>
        <% unless nt.mark_readed %>
          <div class="dot-unread-message"></div>
        <% end %>
      <% end %>
    <% end %>
  </div>
<% elsif !defined?(@page) %>
  <div class="dropdown-item font-size-16px text-gray-500">
    No notification
  </div>
<% end %>
<script>
</script>
```

1.1 pagination erb
```haml

<% if next_page_notification.present? %>
<div id="itemPagination" class="d-none"style="cursor: pointer;" onclick="getMoreNotification('<% next_page_notification %>')" data-total="<%= @total_notification %>">
  <form>
    <hr class="m-0">
    <div class="clearfix"></div>
    <div class="padding-y-10px text-center">
      <p class="m-0 has-spinner" id="loadmore_btn"></p>
    </div>
  </form>
</div>

<script type="text/javascript">
  var nextpage = <%= @next_page_notification %>;
  $("#dataNotification").on("scroll", function() {
    var total = <%= @total_notification %>;
    if ((nextpage - 1) * 5 > total) return false;
    if($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight) {
      $("#itemPagination").removeClass("d-none");
      var btn = $("#loadmore_btn");
      $("#loadmore_btn").buttonLoader('start');
      $.ajax({
        type: 'GET',
        url: "/pages/notifications",
        data: {
          page: nextpage
        },
        success: function(data) {
          $("#loadmore_btn").buttonLoader('stop');
          nextpage ++;
        }
      });
    }
  });

  (function($) {
    $.fn.buttonLoader = function(action) {
      var self = $("#loadmore_btn");
      if (action == 'start') {
        if ($(self).attr("disabled") == "disabled") {
        }
        //disable buttons when loading state
        $('.has-spinner').attr("disabled", "disabled");
        $(self).attr('data-btn-text', $(self).text());
        //binding spinner element to button and changing button text
        $(self).html('<span class="spinner"><i class="fa fa-2x fa-spinner fa-spin"></i></span>');
        $(self).addClass('active');
      }
      //stop loading animation
      if (action == 'stop') {
        var self = $("#loadmore_btn");
        $(self).html('');
        $(self).removeClass('active');
        //enable buttons after finish loading
        $('.has-spinner').removeAttr("disabled");
      }
    }
  })(jQuery);
</script>
<% end %>
```
## CSS
```css
.spinner {
  display: inline-block;
  opacity: 0;
  width: 0;
  -webkit-transition: opacity 0.25s, width 0.25s;
  -moz-transition: opacity 0.25s, width 0.25s;
  -o-transition: opacity 0.25s, width 0.25s;
  transition: opacity 0.25s, width 0.25s;
}

.has-spinner.active {
  cursor: progress;
}

.has-spinner.active .spinner {
  opacity: 1;
  width: auto;
}

.has-spinner.btn.active .spinner {
  min-width: 20px;
}
```
## JS
1. javascript for pagination
```js
$("#dataNotification").append("<%= j render 'layouts/shared/pages/item_notifications', notifications: @notifications, current_page_notification: @current_page_notification %>");
$("#dataPagination").empty().append("<%= j render 'layouts/shared/pages/pagination_notifications', next_page_notification: @next_page_notification %>");
```
2. load js

```js
<script type="text/javascript">
  var nextpage = <%= @next_page_notification %>;
  $("#dataNotification").on("scroll", function() {
    var total = <%= @total_notification %>;
    if ((nextpage - 1) * 5 > total) return false;
    if($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight) {
      $("#itemPagination").removeClass("d-none");
      var btn = $("#loadmore_btn");
      $("#loadmore_btn").buttonLoader('start');
      $.ajax({
        type: 'GET',
        url: "/pages/notifications",
        data: {
          page: nextpage
        },
        success: function(data) {
          $("#loadmore_btn").buttonLoader('stop');
          nextpage ++;
        }
      });
    }
  });

  (function($) {
    $.fn.buttonLoader = function(action) {
      var self = $("#loadmore_btn");
      if (action == 'start') {
        if ($(self).attr("disabled") == "disabled") {
        }
        //disable buttons when loading state
        $('.has-spinner').attr("disabled", "disabled");
        $(self).attr('data-btn-text', $(self).text());
        //binding spinner element to button and changing button text
        $(self).html('<span class="spinner"><i class="fa fa-2x fa-spinner fa-spin"></i></span>');
        $(self).addClass('active');
      }
      //stop loading animation
      if (action == 'stop') {
        var self = $("#loadmore_btn");
        $(self).html('');
        $(self).removeClass('active');
        //enable buttons after finish loading
        $('.has-spinner').removeAttr("disabled");
      }
    }
  })(jQuery);
</script>
```
