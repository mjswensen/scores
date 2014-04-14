
$(function ()
{
	//populates the game types dropdowns
	$.getJSON( "[url]/game_types", function(json) 
	{
		var values = [];

	  	$.each(json.items, function (item) 
	  	{
	  		values.push('<option value="' + item.id + '">' + item.name + '</option>');
	  	});

	  	var html = values.join("");		

	  	$("#game_type").html(html);
	  	$("#game_type_leader").html(html);

	  	console.log( "game_type load success" );
	})

	.fail( function () 
	{
		console.log( "game_types failed to load" );
	});

	// populates the players dropdowns
	$.getJSON( "[url]/players", function(json) 
	{
		var values = [];

	  	$.each(json.items, function (item) 
	  	{
	  		values.push('<option value="' + item.id + '">' + item.first_name + ' \"' + item.nickname + '\" ' + item.last_name + '</option>');
	  	});

	  	var html = values.join("");		

	  	$("#player1").html(html);
	  	$("#player2").html(html);

	  	console.log( "players load success" );
	})

	.fail( function () 
	{
		console.log( "players failed to load" );
	});

});

