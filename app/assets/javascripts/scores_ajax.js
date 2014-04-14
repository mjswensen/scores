
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

	//create a new game in the DB
	$("#new_game_form").submit( function(event)
	{
		event.preventDefault();

		var game_form = $(this);

		var a = [];
		var type = $("#game_type").value();

		var p1 = new Object();
		p1.score = $("#part1_score").value();
		p1.players = [$("#player1").value()]; //TODO: will eventually need to change to add multiple
		a.push(p1);

		var p2 = new Object();
		p2.score = $("#part2_score").value();
		p2.players = [$("#player2").value()]; //TODO: will eventually need to change to add multiple players 
		a.push(p2);

		var pars = JSON.stringify(a);

		$.post(game_form.attr("action"), {game_type: type, participants: pars}, function ()
		{
			//TODO: update rankings based on new game

			console.log( "game created" );
		})

		.fail( function () 
		{
			console.log( "game not created" );
		});

	});

	//create a new game in the DB
	$("#new_player_form").submit( function(event)
	{
		event.preventDefault();

		var player_form = $(this);

		$.post(player_form.attr("action"), player_form.serialize(), function ()
		{
			//TODO: update rankings based on new player

			console.log( "player created" );
		})

		.fail( function () 
		{
			console.log( "player not created" );
		});
	});

});


