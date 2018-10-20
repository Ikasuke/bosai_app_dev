

$(document).on('turbolinks:load', function (e) {
   // controller名acion名
     var controller_name =   $('body').data('controller')
     var action_name =   $('body').data('action')
     console.log(controller_name +'#' + action_name); 

   // actionがadminhomeだったときのみ、実施
     if (action_name == 'adminhome') {
       
        // カテゴリ表示 adminhome画面にカテゴリ編集画面を表示させる
        $.get('categories.html', {      
        }, function(data){
               $('#category_show').html(data);
        });

       // 変更ボタン&deleteボタンで発火　 ajaxが成功したら、category表示のhtmlを書き換える
        $(document).on('ajax:success',function(e){
           
            $.get('categories.html', {      
            }, function(data){
                   $('#category_show').html(data);
            });
            $('#change_info').text( e.detail[0].action + "されました　(" +e.detail[0].category_name + ")"  );
            console.log(e.detail[0]);
            console.log('変更成功');
        });    

       

     }
   

   
});  //document end


