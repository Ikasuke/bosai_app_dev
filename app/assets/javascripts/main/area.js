$(document).on('turbolinks:load', function () {
    
   // controller名acion名
   var controller_name =   $('body').data('controller')
   var action_name =   $('body').data('action')
　 var state = controller_name + "#" + action_name
   
   
   // actionがprofileだったときのみ、実施
  if (state == 'users#profile') {
    console.log("OK");
  // 都道府県を選択するセレクトボックスを作成
  $.get('/user/area_city.json',{  
  },
    function(data){
       for(var i = 0; i < data.length; i++){
           $('#user_area1').append("<option value=" +data[i].name + " id=area1_"+i+ " >" +data[i].name+  "</option>");  //都道府県を表示させる 
       }
    });

    // 都道府県を選択してから地域が選択できるように処理
      // user_area1がセレクトされると発火
    $('#user_area1').on('change',function(e){ 
        $('#user_area2').empty();  // セレクトボックスをからにする　そうしないと発火するごとにセレクトボックスの中身が追加される
          var index = e.target.selectedOptions[0].id.slice(6);  // jsonに格納されているハッシュの番号が出てくる
          var area1 = e.target.value; // user_area1で選択した値 つまり選択した都道府県 
        console.log(area1);
        console.log(index);
         // 地域を選択するセレクトボックス作成
         $.get('/user/area_city.json',{  
        },
         function(data){
             var len = data[index].city.length; 
             for(var j = 0; j < len; j++){
              console.log(len);
                $('#user_area2').append("<option value=" +data[index].city[j].city + ">" +data[index].city[j].city+ "</option>");
             }
         });
      
    });  // $('#user_area1').on(change) end

      
  }  //  if (action_name == 'profile') end

 

//////////
  // murmurs/indexだったときのみ、実施
  if (state == 'murmurs#index' || state == 'items#index' ) {
    console.log("OK");
  // 都道府県を選択するセレクトボックスを作成
  $('#area1').append("<option value=" +"全国" + ">" +"全国"+ "</option>");
  $.get('/user/area_city.json',{  
  },
    function(data){
        for(var i = 0; i < data.length; i++){
           $('#area1').append("<option value=" +data[i].name + " id=area1_"+i+ " >" +data[i].name+  "</option>");  //都道府県を表示させる 
        }
    });

    // 都道府県を選択してから地域が選択できるように処理
      // area1がセレクトされると発火
    $('#area1').on('change',function(e){  
        $('#area2').empty();  // セレクトボックスをからにする　そうしないと発火するごとにセレクトボックスの中身が追加される
          var index = e.target.selectedOptions[0].id.slice(6);  // jsonに格納されているハッシュの番号が出てくる
          var area1 = e.target.value; // user_area1で選択した値 つまり選択した都道府県 
        console.log(area1);
        console.log(index);
         // 地域を選択するセレクトボックス作成
         $('#area2').append("<option value=" +"全地域" + ">" +"全地域"+ "</option>");
         $.get('/user/area_city.json',{  
        },
         function(data){
             var len = data[index].city.length; 
             for(var j = 0; j < len; j++){
                $('#area2').append("<option value=" +data[index].city[j].city + ">" +data[index].city[j].city+ "</option>");
             }
         });
      
    });  // $('#user_area1').on(change) end

      
  }  //  if (action_name == 'profile') end




});  // document 

