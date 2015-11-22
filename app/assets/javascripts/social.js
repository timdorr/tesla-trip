$(function() {

$.ajax({ url: 'http://timdorrteslatrip.tumblr.com/api/read/json?num=50', dataType: 'jsonp'})
  .done(function(data){
    $.each(data.posts, function(i, post){
      if (moment(post["date-gmt"], "YYYY-MM-DD H:m:s Z").isBefore('2015-11-21')) return;
      $("#social-container").append(HandlebarsTemplates["tumblr/"+post.type](post));
    });
  });

});
