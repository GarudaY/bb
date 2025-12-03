// Deprecated, removed in 19.3
this.legend_camp_unlock_gather <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_gather";
		this.m.Title = "Along the way...";
	}

	function onUpdateScore()
	{
		return;
	}
});

