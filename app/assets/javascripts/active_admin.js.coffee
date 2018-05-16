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
