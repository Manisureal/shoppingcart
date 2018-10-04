$('.order-item-'+"<%=@order_item.id%>").remove()
$(".flashes").html("<div class='flash flash_notice'>"+"Order Item #<%=@order_item.id%>, deleted successfully!"+"<\div>")
# $(".flashes").html("<div class='flash flash_notice'>"+'<%= j render partial: "shared/flashes" %>'+"Order Item deleted successfully!"+"<\div>")
# document.location.reload()

