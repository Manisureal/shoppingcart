#= require active_admin/base
# //= require select2
//= require chosen-jquery
# //= require cocoon

#$ ($) ->
  #$('#selecttwo').select2()
  #return

$ ->
  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    #width: '200px'
    width: 'calc(80% - 10px)'

$ ->
  # enable chosen js
  $('.chosen-select2').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    #width: '200px'
    width: '100%'

$ ->
  $('.admin_staffs #wrapper  #active_admin_content .sidebar').remove()
  $(".admin_staffs #collection_selection").width("130%")

$ ->
  $('.user_selector').hide()
  $('.company-select').change ->
    value = $(this).val()
    console.log 'selected' + value
    $('.user-select').val ''
    $('.user_selector').hide()
    $('.company-' + value).show()
    $('.company-address-select').val(value)
    return


$ ->
  hiddenSidebar = ->
    $('.sidebar').hide()
    $('#main_content_wrapper #collection_selection').width '130%'
    return

  addHiddenClassName = ->
    $('.sidebar').addClass('hidden')
    return

  showSideBar = ->
    hiddenSidebar()
    addHiddenClassName()
    grabSearchBtn = $('.action_items .action_item a img').on('click', (evt) ->
      evt.preventDefault()
      if $('.sidebar').attr('class') == "sidebar hidden"
        $('#main_content_wrapper #collection_selection').width '100%'
        $('.sidebar').fadeIn 750, 'swing', ->
          $('.sidebar').removeClass('hidden')
          console.log('visible')
      else
        $('.sidebar').fadeOut 750, 'swing', ->
          addHiddenClassName()
          hiddenSidebar()
          console.log('hidden')
      return
    )
    return
  showSideBar()

# This shows the number of outstanding or new orders in chrome tab
$ ->
  title = document.title
  countNewOrders = ->
    countOrders = $('.orders tbody tr').length
    newTitle = '(' + countOrders + ') ' + title
    if countOrders > 0
      document.title = newTitle
      addFavicon()
    return

  changeTitle = ->
    setInterval countNewOrders, 5000
    return
  $('.orders tbody tr').onload = changeTitle()

  addFavicon = ->
    favicon = $('head link')[2]
    favicon.href = 'https://image.ibb.co/bQi5Ey/icons8_circled_c_100.png'
    return

