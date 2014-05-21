$(function(){
  if($('body.index-page.category').length){
    var oldrow = "";
    var form = $('.edit-form');
    form.find('button.cancel-edit').click(function(){
        var tr = $(this).closest('tr.category');
        tr.replaceWith(oldrow);
        $('a.edit.category-link').show();
        return false;
      });
    form.keyup(function(e){ if (e.keyCode == 27) { $(this).find('button.cancel-edit').click(); } });

    $('a.edit.category-link').click(function(){
      var tr = $(this).closest('tr');
      $('a.edit.category-link').hide();
      oldrow = tr.clone(true);
      tr.empty();
      form.clone(true).appendTo(tr);
      tr.find('button').focus();


      tr.find('input.category-name').val(oldrow.find('.view.category-name').text());
      tr.find('textarea.category-notes').val(oldrow.find('.view.category-notes').html());

      tr.find('form').attr('action','/categories/'+oldrow.attr('data-rapid-context').split(':')[1]);
      return false;
    });
}});
