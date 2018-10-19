

$(document).on('turbolinks:load', function () {

    $(document).on('ajax:success',function(e){
        console.log('test');
        console.log(e.detail[0]);
    });

});  //document end


