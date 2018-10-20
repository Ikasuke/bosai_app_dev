

$(document).on('turbolinks:load', function (e) {
   // controller名acion名
     var controller_name =   $('body').data('controller')
     var action_name =   $('body').data('action')
     console.log(controller_name +'#' + action_name); 

   // actionがadminhomeだったときのみ、実施
     if (action_name == 'adminhome') {
       
        // カテゴリ表示
        $.get('categories.html', {      
        }, function(data){
               $('#category_show').html(data);
        });
       // 変更ボタン
        $(document).on('ajax:success',function(e){
            $('#change_info').text("変更されました　(" +e.detail[0].category_name + ")"  );
            console.log(e.detail[0].category_name);
            console.log('変更成功');
            console.log(e);
        });    

     }

   
});  //document end


