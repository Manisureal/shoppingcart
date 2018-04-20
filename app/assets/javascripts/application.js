
//= require jquery
//= require bootstrap
//= require rails-ujs
//= require_tree .

$("#mats-widget").change(function() {

  alert("Pack Size:" + $(this).data("pack_size"));
});
