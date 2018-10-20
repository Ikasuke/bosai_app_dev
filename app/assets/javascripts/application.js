// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require tether
//= require activestorage
//= require jquery3
//= require popper
//= require jquery.turbolinks
//= require turbolinks
//= require bootstrap
//= require bootstrap-sprockets
//= require moment
//= require moment/ja
//= require tempusdominus-bootstrap-4.js
//= require_tree ./main


   $(document).on('turbolinks:load', function () {
    $('#datetimepicker1').datetimepicker({
        dayViewHeaderFormat: 'YYYY年 MMMM',
        tooltips: {
            close: '閉じる',
            selectMonth: '月を選択',
            prevMonth: '前月',
            nextMonth: '次月',
            selectYear: '年を選択',
            prevYear: '前年',
            nextYear: '次年',
            selectTime: '時間を選択',
            selectDate: '日付を選択',
            prevDecade: '前期間',
            nextDecade: '次期間',
            selectDecade: '期間を選択',
            prevCentury: '前世紀',
            nextCentury: '次世紀'
        },
        format: 'YYYY/MM/DD',
        locale: 'ja',
        showClose: true
    });

    $('.form_pic').on('change',function(e){
        var file = e.target.files[0], 
        reader = new FileReader(),
        $preview =$(".preview");
        t = this;
        console.log(file.type.indexOf("image"));
        // 画像ファイル以外の場合は何もしない
        if (file.type.indexOf("image") < 0) {
             return false;
        }
        
            reader.onload = (function(file){
                console.log(file);
                 return function(e){
                     //既存のプレビューを削除
                     $preview.empty();
                     // change_picの領域にロードした画像を表示するimgタグを追加
                     $preview.append($('<img>').attr({
                               src: e.target.result,
                               class: "preview card-img-bottom",
                               title: file.name
                     }));
                 };
                })(file);
          reader.readAsDataURL(file);      
     });
  

     

}); //document end


