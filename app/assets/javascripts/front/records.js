$(function(){
if($('body.index-page.record').length){
  if($.cookie('records-scroll-position')){
    $(window).scrollTop($.cookie('records-scroll-position'));
    $.removeCookie('records-scroll-position');
  }
  $('select#category, select#region, select#approved').change(function() { jQuery(this).closest('form').submit(); });
  $('.a-checkbox').click(function(){
    $(this).children('input[type=hidden]').val(
     ( ($(this).children('input[type=hidden]').val() == '1') ? '' : '1' )
    );
    $(this).children('i').toggleClass('icon-check');
    $(this).children('i').toggleClass('icon-ban-circle');
    $(this).closest('form').submit();
  });
  $('button.report').click(function(){
    f=$(this).closest('form');
    f.append('<input type="hidden" name="report" value="true"/>');
    f.submit();
  });
  $('#filter-clear').click(function(){
    f=$(this).closest('form');
    f.find('input, select').val('');
    $('#grouping, #onlyme').prop('checked',false);
    f.append('<input type="hidden" name="page" value=""/>');
    f.append('<input type="hidden" name="sort" value=""/>');
  });
  $('a.category-link').click(function(){
    $('select#category').val($(this).attr('data-category-id'));
    $('select#category').closest('form').submit();
    return false;
  });
  $('a.region-link').click(function(){
    $('select#region').val($(this).attr('data-region-id'));
    $('select#region').closest('form').submit();
    return false;
  });

  var form = $('.create-form').clone();
  form.find('.my-new-form').show(); form.find('.my-add-new').hide();
  form.find('form').append('<input id="_method" name="_method" type="hidden" value="PUT"/>');
  form.find('input[type=submit]').parent('td').append('<button class="btn cancel-edit" style="margin-top:5px;"> <i class="icon-remove"> </i> </button>');
  form.find('button.cancel-edit').click(function(){
      tinyMCE.remove("#edit_record_content");
      var tr = $(this).closest('tr.record');
      tr.replaceWith(oldrow);
      $('a.edit.record-link').show();
      return false;
    });
  form.keyup(function(e){ if (e.keyCode == 27) { $(this).find('button.cancel-edit').click(); } });
  form.submit(function(){ $.cookie('records-scroll-position',$(window).scrollTop()) });

  var oldrow = "";

  window.setEditHandler = function(){
  $('a.edit.record-link').click(function(){
    var tr = $(this).closest('tr');
    $('a.edit.record-link').hide();
    oldrow = tr.clone(true);
    tr.empty();
    form.clone(true).appendTo(tr);
    tr.find('button').focus();
    tr.find('textarea.record-content').attr('id','edit_record_content');


    tr.find('input.record-date').val(oldrow.find('.view.record-date').text());
    tr.find('textarea.record-source').val(oldrow.find('.record-source-text').html());
    tr.find('textarea.record-content').val(oldrow.find('.view.record-content').html());
    tr.find('select.record_category').val(tr.attr('data-category-id'));

    tr.find('form').attr('action','/records/'+tr.attr('data-record-id'))

    tr.find('.bootstrap-datetimepicker').datetimepicker();

    tinyMCE.init({
      selector: "#edit_record_content",
      toolbar: ["undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | fullscreen"],
      plugins: "fullscreen,link,image",
      menubar: false,
      statusbar: false,
      browser_spellcheck : true,
      content_style: "p { font-family: 'Helvetica Neue', Helvetica; font-size: 14px; }",
      language: "ru"
    });

    return false;
  })}

}})
