$('.order-item-'+"<%=@order_item.id%>").remove()
document.location.reload()
# $(".flashes").html("<div class='flash flash_notice'>"+'<%= j render partial: "shared/flashes" %>'+"<\div>")
# $(document).html('<%= j render partial: "admin/orders/edit_order_items_form" %>')
# $(document).ajaxSuccess(function(){
#   $(this).parent('.order-item-'+"<%=@order_item.id%>").remove();
# })


