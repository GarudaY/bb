::mods_hookExactClass("events/events/herbs_along_the_way_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "%terrainImage%While heading toward your destination, %volunteer% runs up to you with a bundle of herbs in hand. Now you know this fool knows nothing about plants or wildlife, but %they_volunteer% seems rather persistent in wanting to try them out. Something about \'hearing\' of magical powers to be found in the essence of herbs. This talk gets the attention of a few others in the company. Soon, a number of them are asking to try out the \'medicine\' for the good of their brothers.";
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_18.png[/img]From one end comes vomit and from the other shite. It appears the herbs were not worth a try after all. %volunteer% bravely elected %themselves_volunteer% ready to chow down on the mystery plants and, suffice it to say, the proportions which you are seeing come out of %them_volunteer% are definitely mystical in that strange, \'can the body really hold that much?\', sort of way.";
		});
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars ) {
		onPrepareVariables(_vars);
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Volunteer, "volunteer");
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.OtherGuy, "otherguy");
	}
});
