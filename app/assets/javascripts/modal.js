$(function()
{
	$('#add_player').on('click', function ()
	{
		$('#add_player_modal').show();
	});

	// $('#modal').on('click', function ()
	// {
	// 	$('#modal').hide();
	// });

	$('#cancel').on('click', function ()
	{
		$('#add_player_modal').hide();
	});

	$(window).resize(function ()
	{
		resizeModal();
	});

	resizeModal();

	function resizeModal()
	{
		var dTop = (window.innerHeight - $('#dialogue').height()) / 3.0;
		var dLeft = (window.innerWidth - $('#dialogue').width()) / 2.0;

		$('#dialogue').css("top", dTop + "px");
		$('#dialogue').css("left", dLeft + "px");
	}
});