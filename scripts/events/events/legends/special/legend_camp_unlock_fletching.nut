// Deprecated, removed in 19.3
this.legend_camp_unlock_fletching <- this.inherit("scripts/events/event", {
	m = {
		TownName = ""
	},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_fletching";
		this.m.Title = "Along the way...";
	}

	function onUpdateScore()
	{
		return;
	}
});

