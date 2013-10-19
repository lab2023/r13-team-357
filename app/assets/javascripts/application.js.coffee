# This is a manifest file that will be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require jquery.ui.autocomplete
#= require jquery.ui.sortable
#= require turbolinks
#= require bootstrap
#= require hierapolis
#= require cocoon

ready = ->
  width = $(".project-list").width()
  size = $(".project-list").size()
  full_width = (width+15)*(size)
  $('.vertical-scroll').width(full_width)

  $ ->
    $(".vertical-scroll").sortable connectWith: ".vertical-scroll"
  $ ->
    $(".project-list-item").sortable connectWith: ".project-list-item"
    $(".cart").addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all").find(".cart-header").addClass("ui-widget-header ui-corner-all").prepend("<span class='ui-icon ui-icon-minusthick'></span>").end().find ".cart-content"
    $(".cart-header .ui-icon").click ->
      $(this).toggleClass("ui-icon-minusthick").toggleClass "ui-icon-plusthick"
      $(this).parents(".cart:first").find(".cart-content").toggle()

    $(".project-list-item").disableSelection()
  $(".search-query").autocomplete
    source: $(".search-query").data("autocomplete-source")
    messages:
      noResults: null
      results: ->

$(document).ready(ready)
$(document).on('page:load', ready)