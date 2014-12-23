//= require jquery
//= require jquery_ujs

//= require handlebars.runtime
//= require moment

//= require_tree .

Handlebars.registerHelper('timeAgo', function(data) {
  return moment(data, "YYYY-MM-DD H:m:s Z").fromNow();
});
