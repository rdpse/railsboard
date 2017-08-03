# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# # calls action refreshing the partial
$ ->
  $(document).ready ->
    hostname = location.href.match(/([^\/]*)\/*$/)[1]
    setInterval (->
      jQuery.ajax
        url: hostname
        type: 'GET'
        dataType: 'script'
      return
    ), 25000
    # Every 25 seconds
    return
  return
