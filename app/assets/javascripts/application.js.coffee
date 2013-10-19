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
#= require turbolinks
#= require bootstrap
#= require hierapolis

$(document).ready ->
  width = $(".project-list").width()
  size = $(".project-list").size()
  full_width = (width+15)*(size)
  $('.vertical-scroll').width(full_width)

  $(".search-query").autocomplete
    source: $(".search-query").data("autocomplete-source")
    messages:
      noResults: null
      results: ->