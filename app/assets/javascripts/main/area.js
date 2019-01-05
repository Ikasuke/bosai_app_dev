$(document).on('turbolinks:load', function () {
    
   // controller名acion名
   var controller_name =   $('body').data('controller')
   var action_name =   $('body').data('action')
　 var state = controller_name + "#" + action_name
   
   
   // actionがprofileだったときのみ、実施
  if (state == 'users#profile') {
    console.log("OK");
  // 都道府県を選択するセレクトボックスを作成
  $.get('/user/area.json',{  
  },
    function(data){
        for(var i = 0; i < data.length; i++){
           $('#user_area1').append("<option value=" +data[i].pref + " id=area1_"+i+ " >" +data[i].pref+  "</option>");  //都道府県を表示させる 
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
         $.get('area.json',{  
        },
         function(data){
             var len = data[index].reg.length; 
             for(var j = 0; j < len; j++){
                $('#user_area2').append("<option value=" +data[index].reg[j] + ">" +data[index].reg[j]+ "</option>");
             }
         });
      
    });  // $('#user_area1').on(change) end

      
  }  //  if (action_name == 'profile') end

 

//////////
  // murmurs/indexだったときのみ、実施
  if (state == 'murmurs#index') {
    console.log("OK");
  // 都道府県を選択するセレクトボックスを作成
  $.get('/user/area.json',{  
  },
    function(data){
        for(var i = 0; i < data.length; i++){
           $('#area1').append("<option value=" +data[i].pref + " id=area1_"+i+ " >" +data[i].pref+  "</option>");  //都道府県を表示させる 
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
         $.get('/user/area.json',{  
        },
         function(data){
             var len = data[index].reg.length; 
             for(var j = 0; j < len; j++){
                $('#area2').append("<option value=" +data[index].reg[j] + ">" +data[index].reg[j]+ "</option>");
             }
         });
      
    });  // $('#user_area1').on(change) end

      
  }  //  if (action_name == 'profile') end




});  // document 

