
//ajax で commentboxを表示
$(document).on('turbolinks:load', function () {

 

    $('.comments_box').each(function(i,elem){
      
        $.get('/comments.html', {
            item_id: elem.id.slice(18), tab: elem.id.slice(0,4)
            }, function(data){
            elem.innerHTML = data
        });
    }); // each   
  

  }); // document


