$ ->
  $('.datepicker').datepicker(dateFormat: "yy-mm-dd")
  $('#report_min_date').change ->
    $('#report_max_date').datepicker 'option', 'minDate', new Date($('#report_min_date').val() + " 05:00")
    if $('#report_max_date').val() < $(this).val()
      $('#report_max_date').val $(this).val()

  $('#report2_min_date').change ->
    if $('#report2_max_date').val() < $(this).val()
      $('#report2_max_date').val $(this).val()
    $('#report2_max_date').datepicker 'option', 'minDate', new Date($('#report2_min_date').val() + " 05:00")

  $('#report_min_date').change()
  $('#report2_min_date').change()
