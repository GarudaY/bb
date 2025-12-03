// Deprecated, removed in 19.3
this.legend_camp_unlock_heal <- this.inherit("scripts/events/event", {
	m = {
		TownName = ""
	},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_heal";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
	}

	function onUpdateScore()
	{
		return;
	}

});

