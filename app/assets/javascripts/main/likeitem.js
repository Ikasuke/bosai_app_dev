$(document).on('ajax:error',function(e){
       if(e.detail[1] == "Unprocessable Entity"){
        console.log("error");
        $('.error').text('既に登録されています');
       } 
});
