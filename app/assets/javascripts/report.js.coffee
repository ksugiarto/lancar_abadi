# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$("#sale_pdf").click ->
    transaction_start_date = $("#transaction_start_date").val()
    transaction_end_date = $("#transaction_end_date").val()
    customer_id = $("#customer_id").val()
    status = $("#status").val()
    sort = $("#sort").val()
    window.open("/report/sale_filter?transaction_start_date=" + transaction_start_date + "&transaction_end_date=" + transaction_end_date + "&customer_id=" + customer_id + "&status=" + status + "&sort=" + sort + "&format=pdf", '_newtab');