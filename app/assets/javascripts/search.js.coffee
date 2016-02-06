jQuery ->
  $("#q").autocomplete(
    source: "/search/autocomplete",
    minLength: 2
  )###