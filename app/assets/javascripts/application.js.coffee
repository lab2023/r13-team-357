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
#= require jquery_ujs
#= require jquery.purr
#= require best_in_place
#= require jquery_ujs
#= require jquery.ui.autocomplete
#= require jquery.ui.sortable
#= require bootstrap
#= require hierapolis
#= require cocoon
#= require bootstrap-datepicker/core
#= require bootstrap-datepicker/locales/bootstrap-datepicker.fr

$(document).ready ->
  $('.best_in_place').best_in_place()
  $.datepicker.setDefaults
    showOn: "both"
    buttonImageOnly: true
    buttonImage: "calendar.gif"
    buttonText: "Calendar"

  $(".checklist_check").click ->
    if $(this).is(":checked")
      $.ajax
        url: "/checklists/" + $(this).val() + '/done'
        type: "PUT"
        data: {}
        contentType: "application/json"
        success: (result) ->

  $("#collaborator_user_id").autocomplete
      source: $('#collaborator_user_id').data('autocomplete-source')
      autoFocus: true

  width = $(".project-list").width()
  size = $(".project-list").size()
  full_width = (width+15)*(size)
  $('.vertical-scroll').width(full_width)
  #List drag & drop
  $ ->
    $(".vertical-scroll").sortable
      update: (event, ui) ->
        item = ui.item.attr('id')
        sort = $(".vertical-scroll").sortable('toArray')
        URL = "/lists/" + item + '/move'
        list =
          id: item
          sort: sort
        $.ajax
          url: URL
          type: "PUT"
          data: JSON.stringify(list)
          contentType: "application/json"
          success: (result) ->

      connectWith: ".vertical-scroll"
    $(".panel-default").addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all").find(".panel-heading").addClass("ui-widget-header ui-corner-all").prepend("<span class='ui-icon ui-icon-minusthick'></span>").end().find ".panel-body"
    $(".panel-heading .ui-icon").click ->
      $(this).toggleClass("ui-icon-minusthick").toggleClass "ui-icon-plusthick"
      $(this).parents(".panel-default:first").find(".panel-body").toggle()
    $(".vertical-scroll").disableSelection()

  #Card drag & drop
  $ ->
    arr = []
    $(".project-list-item").sortable

      change: (event, ui) ->
        arr.push(event.target)

      stop: (event, ui) ->
        if arr.length == 1
          item = ui.item.attr('id')
          list = $(this).parent().attr('id')
          sort = $(this).sortable('toArray')
          URL = "/cards/" + item + '/move'
          card =
            id: item
            list: list
            sort: sort
          $.ajax
            url: URL
            type: "PUT"
            data: JSON.stringify(card)
            contentType: "application/json"
            success: (result) ->
        arr = []
      receive: (event, ui) ->
        document.trk = ui
        item = ui.item.attr('id')
        list = $(this).parent().attr('id')
        sort = $(this).sortable('toArray')
        URL = "/cards/" + item + '/move'
        card =
          id: item
          list: list
          sort: sort
        $.ajax
          url: URL
          type: "PUT"
          data: JSON.stringify(card)
          contentType: "application/json"
          success: (result) ->
      connectWith: ".project-list-item"
    $(".card").addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all").find(".card-header").addClass("ui-widget-header ui-corner-all").prepend("<span class='ui-icon ui-icon-minusthick'></span>").end().find ".card-content"
    $(".card-header .ui-icon").click ->
      $(this).toggleClass("ui-icon-minusthick").toggleClass "ui-icon-plusthick"
      $(this).parents(".card:first").find(".card-content").toggle()
    $(".project-list-item").disableSelection()
