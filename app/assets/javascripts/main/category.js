$(document).on('turbolinks:load', function () {
    
///////  edit 用処理　最初のカテゴリー表示 /////    
 var category_id = $(".category_id").val();  // editの場合に使用　元々のcategory_idを格納
 if(category_id ==1){   //waterを選択している
    $('#category_display').html("水・飲料");
        document.getElementById("category_display").style.display = "block";   //大項目を表示する
        document.getElementsByClassName("water_icon")[0].style.color = "#4080ff";   // 大項目1を濃くする
        document.getElementsByClassName("food_icon")[0].style.color = "#e0e0e0";         //大項目2を薄くする  
        document.getElementsByClassName("goods_icon")[0].style.color = "#fff080";         //大項目3を薄くする  
        //大項目１に準じた小項目をだす
        var data = JSON.parse($(".water_icon")[0].id);
      for(var i = 0; i < data.length; i++){    
        $('#item_subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>"); 
       }
 }
  if(category_id ==2){
    $('#category_display').html("食料品");
    document.getElementById("category_display").style.display = "block";   //大項目を表示する
    document.getElementsByClassName("food_icon")[0].style.color = "#808080";    //大項目2を濃くする 
    document.getElementsByClassName("water_icon")[0].style.color = "#e0e0ff";         //大項目1を薄くする  
    document.getElementsByClassName("goods_icon")[0].style.color = "#fff080";         //大項目3を薄くする
     //大項目2に準じた小項目をだす
    var data = JSON.parse($(".food_icon")[0].id);
    for(var i = 0; i < data.length; i++){ 
      $('#item_subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");   
  }
  
   }
  if(category_id ==3){
        $('#category_display').html("防災グッズ");
        document.getElementById("category_display").style.display = "block";   //大項目を表示する
        document.getElementsByClassName("goods_icon")[0].style.color = "#f8c10e";        //大項目3を濃くする
        document.getElementsByClassName("water_icon")[0].style.color = "#e0e0ff";         //大項目1を薄くする  
        document.getElementsByClassName("food_icon")[0].style.color = "#e0e0e0";         //大項目2を薄くする 
        //大項目３に準じた小項目をだす
        var data = JSON.parse($(".goods_icon")[0].id);
        for(var i = 0; i < data.length; i++){   
          $('#item_subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");  
      }
   }


///// new & edit 大項目をクリックした場合の処理 //////   
    $('.water').on('click',function(e){ 
        $('#item_subcategory_id').empty();  // 小項目のセレクトボックスを空にする
        $('#category_display').html('水・飲料');
        document.getElementById("category_display").style.display = "block";   //大項目を表示する
        document.getElementsByClassName("water_icon")[0].style.color = "#4080ff";   // 大項目1を濃くする
        document.getElementsByClassName("food_icon")[0].style.color = "#e0e0e0";         //大項目2を薄くする  
        document.getElementsByClassName("goods_icon")[0].style.color = "#fff080";         //大項目3を薄くする  
        //大項目１に準じた小項目をだす
      var data = JSON.parse(e.target.id);
      for(var i = 0; i < data.length; i++){    
        $('#item_subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");  //都道府県を表示させる 
    }

    });
    $('.food').on('click',function(e){ 
        $('#item_subcategory_id').empty();
        $('#category_display').html('食料品');
        document.getElementById("category_display").style.display = "block";   //大項目を表示する
        document.getElementsByClassName("food_icon")[0].style.color = "#808080";    //大項目2を濃くする 
        document.getElementsByClassName("water_icon")[0].style.color = "#e0e0ff";         //大項目1を薄くする  
        document.getElementsByClassName("goods_icon")[0].style.color = "#fff080";         //大項目3を薄くする
         //大項目2に準じた小項目をだす
        var data = JSON.parse(e.target.id);
        for(var i = 0; i < data.length; i++){ 
          $('#item_subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");  //都道府県を表示させる 
      }
   
       }); 
    $('.goods').on('click',function(e){ 
        $('#item_subcategory_id').empty();
        $('#category_display').html('防災グッズ');
        document.getElementById("category_display").style.display = "block";   //大項目を表示する
        document.getElementsByClassName("goods_icon")[0].style.color = "#f8c10e";        //大項目3を濃くする
        document.getElementsByClassName("water_icon")[0].style.color = "#e0e0ff";         //大項目1を薄くする  
        document.getElementsByClassName("food_icon")[0].style.color = "#e0e0e0";         //大項目2を薄くする 
        //大項目３に準じた小項目をだす
        var data = JSON.parse(e.target.id);
        for(var i = 0; i < data.length; i++){   
          $('#item_subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");  //都道府県を表示させる 
      }
   
       });

/////////////// 検索用 ////// ///////////  /
$('.water_search').on('click',function(e){ 
    $('#subcategory_id').empty();  // 小項目のセレクトボックスを空にする
    $('#category_display').html('水・飲料<input value=1 type="hidden" name="category_id" >');
    document.getElementById("category_display").style.display = "block";   //大項目を表示する
    document.getElementsByClassName("water_icon")[0].style.color = "#4080ff";   // 大項目1を濃くする
    document.getElementsByClassName("food_icon")[0].style.color = "#e0e0e0";         //大項目2を薄くする  
    document.getElementsByClassName("goods_icon")[0].style.color = "#fff080";         //大項目3を薄くする  
    //大項目１に準じた小項目をだす
    　  $('#subcategory_id').append("<option value=0>" +"全て"+  "</option>");
  var data = JSON.parse(e.target.id);
  for(var i = 0; i < data.length; i++){    
    $('#subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");  //都道府県を表示させる 
  }
});
$('.food_search').on('click',function(e){ 
    $('#subcategory_id').empty();
    $('#category_display').html('食料品<input value=2 type="hidden" name="category_id" >');
    document.getElementById("category_display").style.display = "block";   //大項目を表示する
    document.getElementsByClassName("food_icon")[0].style.color = "#808080";    //大項目2を濃くする 
    document.getElementsByClassName("water_icon")[0].style.color = "#e0e0ff";         //大項目1を薄くする  
    document.getElementsByClassName("goods_icon")[0].style.color = "#fff080";         //大項目3を薄くする
     //大項目2に準じた小項目をだす
     $('#subcategory_id').append("<option value=0>" +"全て"+  "</option>");
    var data = JSON.parse(e.target.id);
    for(var i = 0; i < data.length; i++){ 
      $('#subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");  //都道府県を表示させる 
  }

   }); 
$('.goods_search').on('click',function(e){ 
    $('#subcategory_id').empty();
    $('#category_display').html('防災グッズ<input value=3 type="hidden" name="category_id" >');
    document.getElementById("category_display").style.display = "block";   //大項目を表示する
    document.getElementsByClassName("goods_icon")[0].style.color = "#f8c10e";        //大項目3を濃くする
    document.getElementsByClassName("water_icon")[0].style.color = "#e0e0ff";         //大項目1を薄くする  
    document.getElementsByClassName("food_icon")[0].style.color = "#e0e0e0";         //大項目2を薄くする 
    //大項目３に準じた小項目をだす
    　  $('#subcategory_id').append("<option value=0>" +"全て"+  "</option>");
    var data = JSON.parse(e.target.id);
    for(var i = 0; i < data.length; i++){   
      $('#subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");  //都道府県を表示させる 
  }
   });

///////////////検索　そのあとの表示//////////
var select_category_id = $(".select_category_id").val();  //　元々のcategory_idを格納
if(select_category_id ==1){   //waterを選択している
   $('#category_display').html('水・飲料<input value=1 type="hidden" name="category_id" >');
       document.getElementById("category_display").style.display = "block";   //大項目を表示する
       document.getElementsByClassName("water_icon")[0].style.color = "#4080ff";   // 大項目1を濃くする
       document.getElementsByClassName("food_icon")[0].style.color = "#e0e0e0";         //大項目2を薄くする  
       document.getElementsByClassName("goods_icon")[0].style.color = "#fff080";         //大項目3を薄くする  
       //大項目１に準じた小項目をだす
       $('#subcategory_id').append("<option value=0>" +"全て"+  "</option>");
       var data = JSON.parse($(".water_icon")[0].id);
     for(var i = 0; i < data.length; i++){    
       $('#subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>"); 
      }
}
 if(select_category_id ==2){
   $('#category_display').html('食料品<input value=2 type="hidden" name="category_id" >');
   document.getElementById("category_display").style.display = "block";   //大項目を表示する
   document.getElementsByClassName("food_icon")[0].style.color = "#808080";    //大項目2を濃くする 
   document.getElementsByClassName("water_icon")[0].style.color = "#e0e0ff";         //大項目1を薄くする  
   document.getElementsByClassName("goods_icon")[0].style.color = "#fff080";         //大項目3を薄くする
    //大項目2に準じた小項目をだす
    $('#subcategory_id').append("<option value=0>" +"全て"+  "</option>");
   var data = JSON.parse($(".food_icon")[0].id);
   for(var i = 0; i < data.length; i++){ 
     $('#subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");   
 }
 
  }
 if(select_category_id ==3){
       $('#category_display').html('防災グッズ<input value=3 type="hidden" name="category_id" >');
       document.getElementById("category_display").style.display = "block";   //大項目を表示する
       document.getElementsByClassName("goods_icon")[0].style.color = "#f8c10e";        //大項目3を濃くする
       document.getElementsByClassName("water_icon")[0].style.color = "#e0e0ff";         //大項目1を薄くする  
       document.getElementsByClassName("food_icon")[0].style.color = "#e0e0e0";         //大項目2を薄くする 
       //大項目３に準じた小項目をだす
       $('#subcategory_id').append("<option value=0>" +"全て"+  "</option>");
       var data = JSON.parse($(".goods_icon")[0].id);
       for(var i = 0; i < data.length; i++){   
         $('#subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");  
     }
  }


});