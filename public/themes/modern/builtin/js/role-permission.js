$(document).ready(function() {
	/* $('.module-name').click(function(){
		if ($(this).is(':checked')) {
			$(this).parent().next().find('.permission').prop('checked', true);
		} else {
			$(this).parent().next().find('.permission').prop('checked', false);
		}
	});
	
	$('.permission').click(function() {
		 $this = $(this);
		$container = $this.parents('.permission-container').eq(0);
		if ($this.is(':checked')) {
			not_checked = $container.find('.permission:not(:checked)').length;
			if (!not_checked) {
				$container.find('.module-name').prop('checked', true);
			}
		} else {
			checked = $container.find('.permission:is(:checked)').length;
			console.log(checked);
			if (!checked) {
				$container.find('.module-name').prop('checked', false);
			}
		}
	}); */
	
	$('#id-module').change(function(){
		
		if (this.value == 'semua_module') {
			id_module = '';
		} else {
			id_module = '&id_module=' + this.value;
		}
		 window.location = base_url + 'builtin/role-permission/edit?id=' + $('#id-role').val() + id_module;
		 $(this).prop('disabled', true);
	});
	
	$('.checkall-module-permission').click(function(){
		$(this).parent().next().find('.permission').prop('checked', true);
	});
	
	$('.uncheckall-module-permission').click(function() {
		$(this).parent().next().find('.permission').prop('checked', false);
	});
	
	$('.check-all').click(function(){
		$('.module-name').prop('checked', true);
		$('.permission').prop('checked', true);
	})
	
	$('.uncheck-all').click(function(){
		$('.module-name').prop('checked', false);
		$('.permission').prop('checked', false);
	})
});