

$(document).on('turbolinks:load', function () {

 $('.category_name_btn').click(function(){
    
    n=0;
    while(n < $('.category_name_btn').parent().length){
        n++;
       var id = "category_name_btn_" +n;
       
       if (this.id == id) {
           var category_name = "category_name_" +n;
        console.log(category_name);
        var ele = document.getElementById(category_name); // HTML要素オブジェクトを取得
        console.log(ele); 

        }

    }  
 });

});  //document end

