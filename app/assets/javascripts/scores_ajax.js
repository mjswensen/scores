$(function ()
{
	
	//populates the game types dropdowns
	$.getJSON( "game_types", function(json) 
	{
		var values = [];

	  	json.forEach(function (item) 
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
	$.getJSON( "players", function(json) 
	{
		var values = [];

		values.push('<option value="" disabled selected>Select your option...</option>');

	  	json.forEach(function (item) 
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

	// populates the ranking table
	// $.getJSON( "players", function(json) 
	// {
	// 	var values = [];

	//   	json.forEach(function (item) 
	//   	{
	//   		values.push('<option value="' + item.id + '">' + item.first_name + ' \"' + item.nickname + '\" ' + item.last_name + '</option>');
	//   	});

	//   	var html = values.join("");		

	//   	$("#player1").html(html);
	//   	$("#player2").html(html);

	//   	console.log( "players load success" );
	// })

	// .fail( function () 
	// {
	// 	console.log( "players failed to load" );
	// });
	
	//create a new game in the DB
	$("#new_game_form").submit( function(event)
	{
		event.preventDefault();

		var game_form = $(this);

		var a = [];
		var type = $("#game_type").val();

		var p1 = new Object();
		p1.score = $("#part1_score").val();
		p1.players = [$("#player1").val()]; //TODO: will eventually need to change to add multiple
		a.push(p1);

		var p2 = new Object();
		p2.score = $("#part2_score").val();
		p2.players = [$("#player2").val()]; //TODO: will eventually need to change to add multiple players 
		a.push(p2);

		var pars = JSON.stringify(a);

		if (p1.name == p2.name)
		{
			$('#same_id').show();
		} 
		else
		{
			$.post(game_form.attr("action"), {game_type: type, participants: pars}, function ()
			{
				//TODO: update rankings based on new game

				console.log( "game created" );
			})

			.fail( function () 
			{
				console.log( "game not created" );
			});
		}
	});

	//create a new player in the DB
	$("#new_player_form").submit( function(event)
	{
		event.preventDefault();

		var player_form = $(this);

		$.post(player_form.attr("action"), {first_name: $("#first_name").val(), nickname: $("#nickname").val(), last_name: $("#last_name").val()}, function (json)
		{
			//TODO: get full list of names (even if some have been removed)
			
			//Adds new player to selects
			json.forEach(function (item) 
	  		{
				$('#player1').append('<option value="' + item.id + '">' + item.first_name + ' \"' + item.nickname + '\" ' + item.last_name + '</option>');
				$('#player2').append('<option value="' + item.id + '">' + item.first_name + ' \"' + item.nickname + '\" ' + item.last_name + '</option>');
			});

			console.log( "player created" );
		})

		.fail( function () 
		{
			console.log( "player not created" );
		});
	});

	// hide the same_id error message
	$("#player1").on("change", function() {
		$("same_id").hide();
	});

	// hide the same_id error message
	$("#player2").on("change", function() {
		$("same_id").hide();
	});
});