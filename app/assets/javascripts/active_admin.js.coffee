#= require active_admin/base
//= require select2
//= require chosen-jquery

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
    return


$ ->
  hiddenSidebar = ->
    $('#sidebar').hide()
    $('#main_content_wrapper #collection_selection').width '130%'
    return

  showSideBar = ->
    hiddenSidebar()
    grabSearchBtn = $('.action_items .action_item a').first().on('click', (evt) ->
      evt.preventDefault()
      $('#sidebar').show()
      $('#main_content_wrapper #collection_selection').width '100%'
      return
    )
    return
  showSideBar()


