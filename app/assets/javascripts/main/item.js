$(document).on('turbolinks:load', function () {

if(document.getElementById("check_ok")== null){
}else
{
 document.getElementById("expiry_check_check_val").checked = true;
  document.getElementById("expiry_parts").style.display = "block";
}
 
 

    $('.expiry_check').on("change",function(elem){
       
       if(elem.target.checked == true){
    document.getElementById("expiry_parts").style.display = "block";
              }
       if(elem.target.checked == false){
     document.getElementById("expiry_parts").style.display = "none";
       }
       

    }); // on change
}); // document


