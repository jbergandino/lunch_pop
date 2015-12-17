Deface::Override.new( :virtual_path => "spree/shared/_main_nav_bar",
     :name => "add post a new deal link",
     :insert_bottom => "li#home-link",
     :text => '<li id="home-link" data-hook><%= link_to "Hello", root_path %></li>')