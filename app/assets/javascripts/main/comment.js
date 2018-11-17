//ajax で commentboxを表示
$(document).on('turbolinks:load', function () {

    $('.comments_box').each(function(i,elem){
        //console.log(elem.id.slice(13));
        $.get('comments.html', {
            item_id: elem.id.slice(13)
            }, function(data){
            elem.innerHTML = data
        });
    }); // each
  }); // document