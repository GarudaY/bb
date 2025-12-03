// Deprecated, removed in 19.3
this.legend_camp_unlock_crafting <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_crafting";
		this.m.Title = "At %townname%";
	}

	function onUpdateScore()
	{
		return;
	}


});

