// Deprecated, removed in 19.3
this.legend_camp_unlock_scouting <- this.inherit("scripts/events/event", {
	m = {
		TownName = ""
	},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_scouting";
		this.m.Title = "At %townname%";
	}

	function onUpdateScore()
	{
		return;
	}
});

