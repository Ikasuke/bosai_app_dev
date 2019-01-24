$(document).on('turbolinks:load', function () {

///////////////検索　そのあとの表示//////////
var family_num = $(".family_num").val();  //　検索で家族構成をチェックししたを格納
 if(family_num.includes("0")){
    $("#family_ingredients_0").prop("checked", true);
 }
 if(family_num.includes("1")){
    $("#family_ingredients_1").prop("checked", true);
 }
 if(family_num.includes("2")){
    $("#family_ingredients_2").prop("checked", true);
 }
 if(family_num.includes("3")){
    $("#family_ingredients_3").prop("checked", true);
 }
});