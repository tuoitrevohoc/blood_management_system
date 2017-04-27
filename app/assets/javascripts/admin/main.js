$(document).ready(function() {
  $(".select-on-focus").on("focus", function() {
    $(this).select();
  });
});

function initialize_date_picker(dp_selector) {
  return $(dp_selector).datetimepicker({
      useCurrent: false,
      format: "DD-MM-YYYY",
      showClose: true,
      showClear: true,
      icons: {
        close: "fa fa-check"
      }
    });
}

function capchaChecked() {
  return $("#capcha_confirmation:checked").length > 0 ? true : false;
}

function selectOnFocus(selector) {
  $(selector).on("focus", function() {
    $(this).select();
    return;
  });
}
