$ ->
  $('.datepicker').datepicker(dateFormat: "dd/mm/yy")
  $('#report_min_date').change ->
    minDate = $.datepicker.parseDate "dd/mm/yy", $(this).val()
    maxDate = $.datepicker.parseDate "dd/mm/yy", $("#report_max_date").val()
    $('#report_max_date').datepicker 'option', 'minDate', minDate

    if minDate > maxDate
      $('#report_max_date').val $(this).val()

  $('#report2_min_date').change ->
    minDate = $.datepicker.parseDate "dd/mm/yy", $(this).val()
    maxDate = $.datepicker.parseDate "dd/mm/yy", $("#report2_max_date").val()
    $('#report2_max_date').datepicker 'option', 'minDate', minDate

    if minDate > maxDate
      $('#report2_max_date').val $(this).val()

  $('#report_min_date').change()
  $('#report2_min_date').change()
