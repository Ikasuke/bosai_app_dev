
//ajax で commentboxを表示
$(document).on('turbolinks:load', function () {

 

    $('.comments_box').each(function(i,elem){
      
        $.get('/comments.html', {
            item_id: elem.id.slice(18), tab: elem.id.slice(0,4)
            }, function(data){
            elem.innerHTML = data
        });
    }); // each   
  
 
    $('.form_pic_mc').on('change',function(e){
        var file = e.target.files[0], 
        reader = new FileReader(),
        $preview =$("#preview_"+e.target.classList[0].slice(5));
        t = this;
        console.log(file.type.indexOf("image"));
        // 画像ファイル以外の場合は何もしない
        if (file.type.indexOf("image") < 0) {
             return false;
        }
        
            reader.onload = (function(file){
                console.log(file);
                 return function(e){
                     //既存のプレビューを削除
                     $preview.empty();
                     // change_picの領域にロードした画像を表示するimgタグを追加
                     $preview.append($('<img>').attr({
                               src: e.target.result,
                               class: "preview card-img-bottom",
                               title: file.name
                     }));
                 };
                })(file);
          reader.readAsDataURL(file);      
     });
  


  }); // document


