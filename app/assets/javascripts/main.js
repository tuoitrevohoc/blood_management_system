function showNotification(message, type = "info", from = "top", align = "right") {
  $.notify({
    icon: "notifications",
    message: message
  }, {
    type: type,
    timer: 49000,
    placement: {
      from: from,
      align: align
    }
  });
}
