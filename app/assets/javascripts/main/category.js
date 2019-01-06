$(document).on('turbolinks:load', function () {
    
  

    $('.water').on('click',function(e){ 
        console.log("water");
        var alldata = JSON.parse(e.currentTarget.id.slice(2)); //  選択していないid取得のためにデータを取得
        var data2 =JSON.stringify(alldata[2]);    // 大項目２のid
        var data3 = JSON.stringify(alldata[3]);   // 大項目3のid
        $('#item_subcategory_id').empty();  // 小項目のセレクトボックスを空にする
        document.getElementById("subcategory_display").style.display = "block";   //小項目セレクトボックスを表示する
        document.getElementById(e.target.id).style.color = "#4080ff";   // 大項目1を濃くする
        document.getElementById(data2).style.color = "#e0e0e0";         //大項目2を薄くする  
        document.getElementById(data3).style.color = "#fff080";         //大項目3を薄くする  
        //大項目１に準じた小項目をだす
      var data = JSON.parse(e.target.id);
      for(var i = 0; i < data.length; i++){    
        $('#item_subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");  //都道府県を表示させる 
    }

    });
    　  $('.food').on('click',function(e){ 
        console.log("food");
        var alldata = JSON.parse(e.currentTarget.id.slice(2)); //  選択していないid取得のためにデータを取得
        var data1 =JSON.stringify(alldata[1]);    // 大項目1のid
        var data3 = JSON.stringify(alldata[3]);   // 大項目3のid
        $('#item_subcategory_id').empty();
        document.getElementById("subcategory_display").style.display = "block";   //小項目セレクトボックスを表示する
        document.getElementById(e.target.id).style.color = "#808080";    //大項目2を濃くする 
        document.getElementById(data1).style.color = "#e0e0ff";         //大項目1を薄くする  
        document.getElementById(data3).style.color = "#fff080";         //大項目3を薄くする
         //大項目2に準じた小項目をだす
        var data = JSON.parse(e.target.id);
        for(var i = 0; i < data.length; i++){ 
          $('#item_subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");  //都道府県を表示させる 
      }
   
       }); 
       　  $('.goods').on('click',function(e){ 
        console.log("goods");
        var alldata = JSON.parse(e.currentTarget.id.slice(2)); //  選択していないid取得のためにデータを取得
        var data1 =JSON.stringify(alldata[1]);    // 大項目1のid
        var data2 = JSON.stringify(alldata[2]);   // 大項目2のid
        $('#item_subcategory_id').empty();
        document.getElementById("subcategory_display").style.display = "block";   //小項目セレクトボックスを表示する
        document.getElementById(e.target.id).style.color = "#f8c10e";        //大項目3を濃くする
        document.getElementById(data1).style.color = "#e0e0ff";         //大項目1を薄くする  
        document.getElementById(data2).style.color = "#e0e0e0";         //大項目2を薄くする 
        //大項目３に準じた小項目をだす
        var data = JSON.parse(e.target.id);
        for(var i = 0; i < data.length; i++){   
          $('#item_subcategory_id').append("<option value=" +data[i][1] + " >" +data[i][0]+  "</option>");  //都道府県を表示させる 
      }
   
       });
});