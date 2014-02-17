// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// require bootstrap-modal
// require bootstrap-scrollspy
// require bootstrap-dropdown

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$.fn.ajaxSelect = function(rel) {
  var that = this;

  this.change(function() {
    $.get(rel, {id: that.val()}, null, "script");
  });
}

$.fn.ajaxChange = function(rel) {
  var that = this;

  $.get(rel, {id: that.val()}, null, "script");
  return false;
}

$.fn.keyUp = function(rel) {
  var that = this;

  this.keyup(function() {
    $.get(rel, {id: that.val()}, null, "script");
  })
}

$.fn.onLoad = function(rel) {
  var that = this;

  this.ready(function() {
    $.get(rel, {id: that.val()}, null, "script");
  })
}

$.fn.ajaxPagination = function() {
  this.on("click", function () {
    $(".apple_pagination").html("Silahkan tunggu...")
    $.get(this.href, null, null, "script");
    return false;
  });
}