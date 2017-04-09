function showNotification(message, type = "info", from = "top", align = "right") {
  let types = ["success", "danger", "info", "warning"];
  if ($.inArray(type, types) == -1) {
    type = "danger";
  }
  $.notify({
    icon: "notifications",
    message: message
  }, {
    type: type,
    timer: 4000,
    placement: {
      from: from,
      align: align
    }
  });
}

function scrollToTop() {
  $("html, body").animate({scrollTop: 0}, "slow");
}
