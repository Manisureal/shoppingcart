#Main function to trigger when selecting an item or updating quant

window.onload = ->
  $(document).ready ->
    $('.product-selector').change ->
      counter_id = $(this).data('counter-id')
      product_id = $(this).find(':selected').val()
      getProductInfo(product_id, counter_id)
    $('.quan-tot').change ->
      counter_id = $(this).data('counter-id')
      updateRowTotal(counter_id)
      updateTotalValue()
    return
  return

# For edit purpose to request product info from servers and updates fields

window.getProductInfo = (product_id, counter_id) ->
  $.getJSON('<%= products_path %>/' + product_id + '.json').done (data) ->
    $('#pack-size-' + counter_id).val data.product.pack_size
    $('#price-' + counter_id).val data.product.price
    $('#product-code-' + counter_id).val data.product.product_code
    updateRowTotal(counter_id)
    updateTotalValue()
  return

#To Update OrderItem Row

window.updateRowTotal = (counter_id) ->
  price = $('#price-' + counter_id).val() * $("#order_order_items_attributes_" + counter_id + "_quantity").val()
  $('#total-' + counter_id).val price

#To Update total on of the orderItems on the form

window.updateTotalValue = ->
  total_val = 0.0
  $(".order-item-total").each (i, obj) ->
    total_val += parseFloat($(obj).val())
  $("#total-order-value").val(total_val)
