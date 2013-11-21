$(function() {

$.ajax({ url: 'http://timdorrteslatrip.tumblr.com/api/read/json?num=50', dataType: 'jsonp'})
  .done(function(data){
    $.each(data.posts, function(i, post){
      $("#social-container").append(HandlebarsTemplates["tumblr/"+post.type](post));
    });
  });

});